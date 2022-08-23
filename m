Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D059D28D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiHWHn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiHWHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:43:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46475A16B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:43:48 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220823074343epoutp03e1ea435b39d21f3291e94aa2851495c7~N6YuF4TXE0522405224epoutp034
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:43:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220823074343epoutp03e1ea435b39d21f3291e94aa2851495c7~N6YuF4TXE0522405224epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661240623;
        bh=JU5y7oM6osxoQzFh2Yz2BBlu4xGSfLBnAAkEbsV7ssA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=C6IhTSb5/5BKs9kT/tfz3MJiXcU172eQPEDwEXesClv/na09agmfjnu2gtE4NLXQW
         4tQj+bQOsNh008HxckzXgYpPha/Yr7S347/ugy2Yr1xh6c/XmSiYpvibwbe92DniJ7
         x7W19hSGuReOatKA4AC85bSeTxuq/x+9MfPMv8vA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220823074342epcas2p2bab7e98c5ff666ff946f6d8754c43a9b~N6YtNkfcv2781527815epcas2p2T;
        Tue, 23 Aug 2022 07:43:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MBh7145mcz4x9Q0; Tue, 23 Aug
        2022 07:43:41 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.63.18083.D2584036; Tue, 23 Aug 2022 16:43:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823074341epcas2p13a52fa12dac940c1a42e5fa4c19e7a78~N6YsRZuHg2218622186epcas2p1G;
        Tue, 23 Aug 2022 07:43:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823074341epsmtrp2ad037bf286d79d9beeead84168e4ee5f~N6YsQmGcc2119021190epsmtrp2H;
        Tue, 23 Aug 2022 07:43:41 +0000 (GMT)
X-AuditID: b6c32a46-cb3ff700000046a3-19-6304852d65f3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.AF.14392.C2584036; Tue, 23 Aug 2022 16:43:40 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823074340epsmtip1afb6b57ecf6d0d69f8ead50336e3618a~N6YsDzPG71713717137epsmtip1O;
        Tue, 23 Aug 2022 07:43:40 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
Cc:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <6b5730d7-997e-518b-e0dd-2a20045242c1@linaro.org>
Subject: RE: [PATCH] clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
Date:   Tue, 23 Aug 2022 16:43:40 +0900
Message-ID: <013f01d8b6c4$1036ed30$30a4c790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF1SOsaNiex7/NfbpzpvZw644fnlQKLnxwnAeCRjYWuX5QYEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmqa5uK0uywYpn8hYP5m1js7j+5Tmr
        xd7XW9ktPvbcY7W4vGsOm8WM8/uYLC6ecrU4/Kad1eLftY0sFs/7gEKrdv1hdOD2eH+jld1j
        56y77B6bVnWyedy5tofNo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
        DHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
        5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn3LuygaXgM0fFkdUfmRsY+9m7GDk5JARMJFYf
        WsXUxcjFISSwg1Fi2drFzBDOJ0aJHe9XMYNUCQl8Y5TYvNmui5EDrGPiB2+Imr2MEkcOvYJq
        eMEosWvPS0aQBjYBfYmXHdtYQWwRgTyJ6Tc3s4AUMQt8ZpL48Goq2G5OATuJG/uaWEBsYQF3
        iabpL5hANrAIqErMnREPEuYVsJR4cuECI4QtKHFy5hOwcmYBeYntb+cwQ7ygIPHz6TKoXU4S
        G7v+sUPUiEjM7mwDO05CYA+HxOJt31kgGlwkvkxZCmULS7w6vgUaFlISn9/tZYOwiyWWzvrE
        BNHcwChxedsvqISxxKxn7YwghzILaEqs36UPCRVliSO3oG7jk+g4/JcdIswr0dEmBNGoLnFg
        +3SorbIS3XM+s05gVJqF5LNZSD6bheSDWQi7FjCyrGIUSy0ozk1PLTYqMILHdXJ+7iZGcMLV
        ctvBOOXtB71DjEwcjIcYJTiYlUR4qy8yJAvxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGDK
        zyuJNzSxNDAxMzM0NzI1MFcS53XRZkwWEkhPLEnNTk0tSC2C6WPi4JRqYFokP6Nm+6/US3dk
        U19N9IngkrrWceiL9JL3UX8nCBkcm1ZULx35WGzR+eCWhjWHC42Tn5rdt402XvepOOdda7uY
        dYfPxObgh1Y9qy9khSp5fV2suql86+c5okVZvMukvHgKXtjevC0r5sXzJn32v9iLB+8Wb/m9
        c3rLDf+sAplpqbvkl/yOs13F8qxCjSWgLWVv5ueSk+Iyqi42HPd+qDY5JS4xDAsMXe2qy/L3
        aXLDwp5pFsfOWe1dIFSncn4dT6nmpHXfubfOSSqLNF5w8+RPhlptq93udgFz5lh+9eo67F6f
        dqN8Xe2a37ejvby9gm6nzNnmqy35u1x50un738Q39cSoJQVrPNA43HdWRImlOCPRUIu5qDgR
        AGrLwsFBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnK5OK0uywd+vlhYP5m1js7j+5Tmr
        xd7XW9ktPvbcY7W4vGsOm8WM8/uYLC6ecrU4/Kad1eLftY0sFs/7gEKrdv1hdOD2eH+jld1j
        56y77B6bVnWyedy5tofNo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDLuXdnAUvCZo+LI6o/M
        DYz97F2MHBwSAiYSEz94dzFycQgJ7GaUuHP3NGsXIydQXFbi2bsd7BC2sMT9liOsEEXPGCX+
        nuhnAkmwCehLvOzYBtYgIpAnce3IRrAiZoGfTBLbjv9hBEkICZxglJg/F6yIU8BO4sa+JhYQ
        W1jAXaJp+gsmkCtYBFQl5s6IBwnzClhKPLlwgRHCFpQ4OfMJWDmzgLbE05tPoWx5ie1v5zBD
        HKcg8fPpMqgbnCQ2dv1jh6gRkZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYb
        FhjmpZbrFSfmFpfmpesl5+duYgRHn5bmDsbtqz7oHWJk4mA8xCjBwawkwlt9kSFZiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqY9Gy/bzuz5v5fveW3d
        Vp5ZQd8O3lrYK+sUwfZI+EfMim8nY+KyRf9kFt/zfb6t6MrXfomZ57pLVrjtvVE24295/cql
        M+6/YOSKepN/YasQ89nFPxYuSHtSZnOxdO+rd8XKC/6E3/C2379W2cfVnevLgf8C0jNSMyZJ
        nGtX4dD3UZrlvd4p4KtLvfuF8x+aO5TTjaRe/5sS2VfwcY0ei0TF3jq/KxP7FVT/73/7cqmJ
        xIFIrQy1c27PutfdeDOJ+aufxYtDvpzf011mcgZKp+m3ORiq/Lg1x73+Qdv9wGbh7tnFi3dG
        8hhsmpzkp/gq0vJu8Iu0zTNVPu3x0pHoXW/+8nDDjUWN4ZcEOysTl65TYinOSDTUYi4qTgQA
        22uvYy0DAAA=
X-CMS-MailID: 20220823074341epcas2p13a52fa12dac940c1a42e5fa4c19e7a78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220823073610epcas2p2783d4c70dc57be186822b7ef12fc586a
References: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
        <CGME20220823073610epcas2p2783d4c70dc57be186822b7ef12fc586a@epcas2p2.samsung.com>
        <6b5730d7-997e-518b-e0dd-2a20045242c1@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add Krzysztof Kozlowski (already Samsung SoC maintainer) as Samsung
> > SoC clock maintainer to handle the patches.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Agreed with Sylwester who is recently busy. Let me handle some patches
> > as I already handle rest of Samsung SoC.
> >
> > I plan to send pulls the same way Sylwester did - to Stephen.
> 
> 
> Hi Sam and Chanho,
> 
> Please accept our apologies for any delays in handling the patches.

No problem :)

> 
> I went through archives and grabbed few remaining Samsung clk patchsets:
> 1. bindings:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-
> v6.0/samsung-clk-dt-bindings
> 
> 2. clk:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=next
> /clk
> 
> 3. and DTS via my regular branches.
> 
> Everything should pop-up in next linux-next.
> 
> If something is still missing/pending/lost, please kindly resend.
> 
> Also thanks for your upstream Samsung contributions!

Great. Thanks for your support.

Best Regards,
Chanho Park

