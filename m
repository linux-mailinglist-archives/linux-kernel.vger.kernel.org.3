Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD9535D11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbiE0JMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350544AbiE0JMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:12:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD311E1F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:09:59 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220527090956epoutp04fbcce9b2c71a8b23d89cb0c3ab2f4c5f~y6y4GqUFg1831618316epoutp04l
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220527090956epoutp04fbcce9b2c71a8b23d89cb0c3ab2f4c5f~y6y4GqUFg1831618316epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653642596;
        bh=G9c8XxCztwaSqqn1tS9KYhzziTGYpxXqQjerKQgs/Sg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QArzRxo2c9x21XZKf36wxXOcawIk/nSLFHQ9p5i7AR5hNxjP2XsgpRjWnfrnWZU1o
         kSLEzwIm+zg2GZ6G+ewe0a5d/jacgGBUbpxHm8skJ4OTH3qT0aVhTJoL5//sM+7qy+
         bS0ZV5xJjgaf5kiJ/FRU0lG2HDRRsEM9G9HfszEI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220527090955epcas1p29e8f0814517a5fc88abbeab9229df374~y6y3279vQ1868918689epcas1p21;
        Fri, 27 May 2022 09:09:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.132]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L8fC667VRz4x9QB; Fri, 27 May
        2022 09:09:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.C3.09785.26590926; Fri, 27 May 2022 18:09:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220527090954epcas1p27e29b6bbb556ce1bdd6233597fe2ac8f~y6y2pR-AI1869318693epcas1p20;
        Fri, 27 May 2022 09:09:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220527090954epsmtrp2ca8458a703f97ff94746fc3545651607~y6y2opCwG1550715507epsmtrp2G;
        Fri, 27 May 2022 09:09:54 +0000 (GMT)
X-AuditID: b6c32a36-c87ff70000002639-25-62909562e0d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.CC.11276.26590926; Fri, 27 May 2022 18:09:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220527090954epsmtip2d92ce4c5397c9451006474ebc01ea09c~y6y2fJM5X2556625566epsmtip2v;
        Fri, 27 May 2022 09:09:54 +0000 (GMT)
Subject: Re: [PATCH] extcon: fsa9480: Drop no-op remove function
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3b785922-df17-3f5e-c3a2-be95cf3ea9c2@samsung.com>
Date:   Fri, 27 May 2022 18:09:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220526130754.1587373-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmvm7S1AlJBhteGVqsmrqTxeLyrjls
        FrcbVwCJiZMZHVg8+v8aePRtWcXo8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtAyJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xpIJPcwFJzkrbm2bytjAeIe9i5GTQ0LARGL2
        zZWMXYxcHEICOxglvs/+wwbhfGKUWLf/OVTmG6PE4z19TDAtX/deZYZI7GWUmPX8CSuE855R
        omvXDVaQKmEBB4n1l06ygNgiAoUSP64dAurg4GAWMJfo+mgJEmYT0JLY/+IGG4jNL6AocfXH
        Y0YQm1fATuLAvTdgcRYBVYm7G26BLRYVCJM4ua0FqkZQ4uTMJ2DjOQXcJKbPvwxmMwuIS9x6
        Mp8JwpaXaN46G+xQCYGP7BJX/x9hgfjAReL0syZmCFtY4tXxLdDAkJL4/G4vG0RDM6NEw4vb
        jBBOD6PE0Wd9UN3GEvuXTmaC+EZTYv0ufYiwosTO33MZITbzSbz72sMKUiIhwCvR0SYEUaIs
        cfnBXWgoSkosbu9km8CoNAvJP7OQ/DALyQ+zEJYtYGRZxSiWWlCcm55abFhgBI/u5PzcTYzg
        lKhltoNx0tsPeocYmTgYDzFKcDArifBeeNqbJMSbklhZlVqUH19UmpNafIjRFBjCE5mlRJPz
        gUk5ryTe0MTSwMTMyNjEwtDMUEmcd9W004lCAumJJanZqakFqUUwfUwcnFINTHlM7JHx3zer
        pVisnWe27uaS5OvB/JejX2+abnGntJr9qr1B6/SF1uec3muzvPz6XOhNKUtz89FFZYIZ/sps
        P7XV45TPXN8bwSXlu6ev+e58r+8sPbUnHi6sOpP9ZensUzO9ntbzeE8NXeitzvzr429u/3p3
        lRKB9TP3lLjdMDHbaOzz5Pp/TY30iXxt7TeW73/hOIn1ROik6l1HehiXbWCfwS4jrOkqPP/F
        k3OeN+R2OPtlhRpMeLA59MWFYs5yBxUJ/7IYMxXeLGbl+axHL+Xfmj3Hy2nap09lC9pdAve8
        KHaWzSjIFf66M/3RwaTWI3tqzh3va18hLb5rfSbT742To9W+Oj35/iRENtVmuhJLcUaioRZz
        UXEiANYxSRwSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvG7S1AlJBjuuylismrqTxeLyrjls
        FrcbVwCJiZMZHVg8+v8aePRtWcXo8XmTXABzFJdNSmpOZllqkb5dAlfGkgk9zAUnOStubZvK
        2MB4h72LkZNDQsBE4uveq8wgtpDAbkaJ3o5ciLikxLSLR4HiHEC2sMThw8VdjFxAJW8ZJaZ2
        r2UFqREWcJBYf+kkC4gtIlAo8f7ze7B6ZgFzia6PlhD1MxklWk/3gO1iE9CS2P/iBhuIzS+g
        KHH1x2NGEJtXwE7iwL03YHEWAVWJuxtuMYHYogJhEjuXPGaCqBGUODnzCdguTgE3ienzL4PZ
        zALqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9Nxi
        wwLDvNRyveLE3OLSvHS95PzcTYzguNDS3MG4fdUHvUOMTByMhxglOJiVRHgvPO1NEuJNSays
        Si3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFpSoOfqIegKafSNflP
        2qwH9lzZNOnHsRPzf6yUvMdzY8K2W2zP2kVebLJjz4uLCN6/fFnthm/JCc88NGuedxhqvuQ9
        vLcm8UVnF0NRvM1GPT3tJu7ZHy2+dTJ5qWd3L/ip9Nkn2vTYCvmy/bd+XuC+q/kn8PTH/LsT
        zUozputzx8tuUpnJ9smNd7HKvz1TF6mcuzwnw/Itg3DSzDveIYYHD0U88HKfC7RI3fSC+M7n
        zVcaHqonXu6UKDm08J33sX8XCz+ats45yyJhoxXadMqeU+ire9vfr64eAZWOMfnNm5muPuZc
        urVx36YOYX/bPc3y+x/HKG4+/ZE1zL+CTeak74HdGyS/d8++HV5deVyJpTgj0VCLuag4EQDp
        5YFq+gIAAA==
X-CMS-MailID: 20220527090954epcas1p27e29b6bbb556ce1bdd6233597fe2ac8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526130812epcas1p272b572297501a35f98fa1c6656381cfa
References: <CGME20220526130812epcas1p272b572297501a35f98fa1c6656381cfa@epcas1p2.samsung.com>
        <20220526130754.1587373-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 10:07 PM, Uwe Kleine-König wrote:
> A remove callback that just returns 0 is equivalent to no callback at all
> as can be seen in i2c_device_remove(). So simplify accordingly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/extcon/extcon-fsa9480.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
> index 08bdedbcdb0d..7cff66c29907 100644
> --- a/drivers/extcon/extcon-fsa9480.c
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -324,11 +324,6 @@ static int fsa9480_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int fsa9480_remove(struct i2c_client *client)
> -{
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int fsa9480_suspend(struct device *dev)
>  {
> @@ -376,7 +371,6 @@ static struct i2c_driver fsa9480_i2c_driver = {
>  		.of_match_table = fsa9480_of_match,
>  	},
>  	.probe			= fsa9480_probe,
> -	.remove			= fsa9480_remove,
>  	.id_table		= fsa9480_id,
>  };
>  
> 
> base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> 

Applied it for v5.20-rc1. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
