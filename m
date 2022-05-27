Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E6535D12
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbiE0JN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiE0JMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:12:17 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874A1356B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:09:26 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220527090924epoutp01a9f0125e25cf92198cf74eb2322dc688~y6yaXAzlG0290402904epoutp01U
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:09:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220527090924epoutp01a9f0125e25cf92198cf74eb2322dc688~y6yaXAzlG0290402904epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653642564;
        bh=l/TZsav0OszkbX764K4zWsorfxudmDeJ7M6HuzVL3oQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZWvV7lxx5ycMxkg6WTBuXyGTYpHV6caaAlYYvgfzyQSV4KMOuglEi4nNIpgdgpK5F
         o9zuA7dSuMc5CHbRvTVy9z6b7If6migeusOno2lYmn3Vv17owzIVCuo8/OFXaxPTsK
         aSIuhn1R6PbO4HSnFPi4HrO5dh4m5JusTAf81hmQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220527090923epcas1p3865e3f2c73ee29423a1146695c297c18~y6yZdWwVu2103421034epcas1p3J;
        Fri, 27 May 2022 09:09:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L8fBV0dSSz4x9Pw; Fri, 27 May
        2022 09:09:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.A5.10354.14590926; Fri, 27 May 2022 18:09:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220527090921epcas1p483e785670e3458f9abc9d40bb2e33d84~y6yX5zC8E1883118831epcas1p4V;
        Fri, 27 May 2022 09:09:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220527090921epsmtrp1f0b324853bffd2b2bfd5e00e3d1835fb~y6yX4-KmN0585905859epsmtrp11;
        Fri, 27 May 2022 09:09:21 +0000 (GMT)
X-AuditID: b6c32a38-49fff70000002872-a9-62909541c29f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.BC.11276.14590926; Fri, 27 May 2022 18:09:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220527090921epsmtip13ef99f09c9d58a1972b5028c4c5f3121~y6yXqTvqS0727307273epsmtip19;
        Fri, 27 May 2022 09:09:21 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Add check for platform_driver_register
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, alim.akhtar@samsung.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <377a917b-96b1-14ff-ee57-f841e12c3b41@samsung.com>
Date:   Fri, 27 May 2022 18:09:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220526101215.1519155-1-jiasheng@iscas.ac.cn>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmrq7T1AlJBv82MVo8mLeNzWLJ0aOM
        Fntfb2W32PT4GqvFx557rBaXd81hs5hxfh+TxcVTrhaH37SzWvy7tpHFYtWuP4wO3B7vb7Sy
        e+ycdZfdY9+OzYwem1Z1snncubaHzWPzknqPvi2rGD0+b5IL4IjKtslITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulNJoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ3xa9ct1oIG7oqO054NjNM5
        uxg5OSQETCRu7TzI3MXIxSEksINR4sKGS0wQzidGiSNn5rBBON8YJY4tmssM03K16ShUy15G
        iQOdi6Ba3jNKvF15mLGLkYNDWMBTorM7CiQuInCAUeJB4zGwUcwCbYwST3euYAEZxSagJbH/
        xQ02EJtfQFHi6o/HjCA2r4CdxMbrV9hBbBYBVYld5w6DxUUFwiRObmuBqhGUODnzCdgcTgEb
        iX/7foCdxywgLnHryXwmCFteYvvbOWCnSghc4JD4cvAUE8QPLhIbD7xjhbCFJV4d38IOYUtJ
        vOxvY4doaGaUaHhxmxHC6WGUOPqsjwWiylhi/9LJTCB/MgtoSqzfpQ8RVpTY+XsuI8RmPol3
        X3tYQUokBHglOtqEIEqUJS4/uAt1g6TE4vZOtgmMSrOQ/DMLyQ+zkPwwC2HZAkaWVYxiqQXF
        uempxYYFJvD4Ts7P3cQITsVaFjsY5779oHeIkYmD8RCjBAezkgjvhae9SUK8KYmVValF+fFF
        pTmpxYcYTYEhPJFZSjQ5H5gN8kriDU0sDUzMjIxNLAzNDJXEeXunnk4UEkhPLEnNTk0tSC2C
        6WPi4JRqYHJ4qVU9+duPctuFYsoPS6UYpcOnNdtdmnha0ulpxallk5h/+3EeCXRecbJ+os3m
        2xuDVgj4TNL/0rVnRvD2+LpLm143p/789f5xsO2vjvX/hG11U3p/qDx5s/MD0xzrNGaNtHoT
        w9OJFgsCpevldeLucpSc12c8tEs+O9DWXzRteozG7pxJZVu5uucpiRyU0C26Y/3UhCda2lRO
        nPd/g1Gs4QnziI+T0xni9tl18pwzjGp6zPvRYq7P9qfdrUGLe3xUdS7tO206eUEO17F3rYui
        DYKezIr9tdW02/Ss7QFT/RvZdRN1g2LV24u1tpzw1PqYwXTx0WmloLiONBEP4wPbFztPn2yf
        dvDbydmHlViKMxINtZiLihMBxQYIjk4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnK7j1AlJBhdnyFg8mLeNzWLJ0aOM
        Fntfb2W32PT4GqvFx557rBaXd81hs5hxfh+TxcVTrhaH37SzWvy7tpHFYtWuP4wO3B7vb7Sy
        e+ycdZfdY9+OzYwem1Z1snncubaHzWPzknqPvi2rGD0+b5IL4IjisklJzcksSy3St0vgyvi1
        6xZrQQN3RcdpzwbG6ZxdjJwcEgImElebjjJ3MXJxCAnsZpQ409bGCpGQlJh2ESTBAWQLSxw+
        XAwSFhJ4yyjxbqIgSFhYwFOiszsKpFVE4ACjxLOv2xhBHGaBNkaJ251PoIb2M0r8e9vDAtLN
        JqAlsf/FDTYQm19AUeLqj8eMIDavgJ3ExutX2EFsFgFViV3nDoPFRQXCJHYuecwEUSMocXLm
        E7A5nAI2Ev/2/WAGsZkF1CX+zLsEZYtL3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYF
        jCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC41FLcwfj9lUf9A4xMnEwHmKU4GBW
        EuG98LQ3SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam
        gGsv5hr61cS3bf3/48OM6fvPTXgZuffrJbE6FXmHR3NN1VZpfvjbfyboV41p/Dyx8kXlizfv
        UX9ks+BiimH92oavHWsNponObHU9cN59TvB9hbNl637IT9nBF3As+jKrO/va9cn7DvH/Pc1S
        JFV0/3B53KXsy9rxcUWWXCG7apRn/H5osZHjp35tWn7W/0/Tr7l6zpgbwXupdv6/8lWez+ed
        y3L46H19a6rRlqfzzgqkTtgwJfjVl02ni4RPvfm0cO3MR2/4op/M73AJLvy+86FidOveKyUy
        uzh2v5325GzIR8Hwu7Ebs9J83udWpIhoPPRx2H5ONdulqpUx6/2DH5PvZjIEvgoPZ70llGWx
        KEyJpTgj0VCLuag4EQDtxTu+NgMAAA==
X-CMS-MailID: 20220527090921epcas1p483e785670e3458f9abc9d40bb2e33d84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526101239epcas1p33aec5e8e0386d6b986ffb16bc3f68bab
References: <CGME20220526101239epcas1p33aec5e8e0386d6b986ffb16bc3f68bab@epcas1p3.samsung.com>
        <20220526101215.1519155-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 7:12 PM, Jiasheng Jiang wrote:
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/clk/samsung/clk-exynos5-subcmu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
> index 65c82d922b05..8b090481a9dc 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.c
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
> @@ -188,8 +188,18 @@ static struct platform_driver exynos5_clk_driver __refdata = {
>  
>  static int __init exynos5_clk_drv_init(void)
>  {
> -	platform_driver_register(&exynos5_clk_driver);
> -	platform_driver_register(&exynos5_subcmu_driver);
> +	int ret;
> +
> +	ret = platform_driver_register(&exynos5_clk_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&exynos5_subcmu_driver);
> +	if (ret) {
> +		platform_driver_unregister(&exynos5_clk_driver);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  core_initcall(exynos5_clk_drv_init);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
