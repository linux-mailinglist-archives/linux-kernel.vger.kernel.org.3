Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C944E1F44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiCUDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243641AbiCUDQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:16:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9742315E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:14:37 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220321031432epoutp023b2041355564d9defdbb62844c331639~eRucZTr9b2751927519epoutp02V
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:14:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220321031432epoutp023b2041355564d9defdbb62844c331639~eRucZTr9b2751927519epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647832472;
        bh=+sXwCEW3mW2sBV52D5/Cek7rU4aPA8/VK9Jgbz0yWmE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n1cS5VMMlHXdNMkagq5PD5WkZXz66jJr7NLOV6Tq5Tmn93Ka1zbuT03WcO1wx35K6
         7DhP8p6BXjHLzqkHF7e86FVFi1qb0xks/mC6esfyxeP1mzVhmmofcctKNibGXz4PAe
         QVHbcTGLfeLY4zNIEivoYxx1RyM6u1psq8S8w/Cc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220321031431epcas1p32f0935dc303f7369ceae86585dd9eed3~eRub3yE4x0183401834epcas1p3U;
        Mon, 21 Mar 2022 03:14:31 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KMKTt1Dzpz4x9QB; Mon, 21 Mar
        2022 03:14:26 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.C5.21932.29DE7326; Mon, 21 Mar 2022 12:14:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220321031425epcas1p21cc0552e9712818d95b39747cfc3166a~eRuV55cd11508815088epcas1p20;
        Mon, 21 Mar 2022 03:14:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220321031425epsmtrp2bc3634279bd20ef71f9c17652dd7160d~eRuV5EIzW1070910709epsmtrp2-;
        Mon, 21 Mar 2022 03:14:25 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-d3-6237ed92eba0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.17.29871.09DE7326; Mon, 21 Mar 2022 12:14:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321031424epsmtip26ce8e671a406bff7abd96a260df92c06~eRuVsX4lV1929219292epsmtip2K;
        Mon, 21 Mar 2022 03:14:24 +0000 (GMT)
Subject: Re: [PATCH v4 00/15] rk3399: Clean up and enable DDR DVFS
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c909b9ce-d787-e5fe-6a92-473cd24d0858@samsung.com>
Date:   Mon, 21 Mar 2022 12:39:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmru6kt+ZJBjMWcFhs+vie1eLV5j1s
        FvOPnGO1+P/oNavFjw2nmC3ONr1ht9j0+BqrxeVdc9gsPvceYbT49OA/s8XtxhVsFq17j7A7
        8HjMbrjI4rFpVSebx+Yl9R5/Z+1n8ejbsorRY/u1ecwenzfJBbBHZdtkpCampBYppOYl56dk
        5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2qpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjOWP//N3PBM/GK5ktXmBsY
        W4S7GDk5JARMJN7fvs8CYgsJ7GCUONPi0MXIBWR/YpRof9vEAuF8Y5Q42XmDHabj+aYXrBCJ
        vYwSOxoamSCc94wSn87uYwOpEhZwkpj0diMziC0icJxR4vjvPJAiZoF3jBKrm76DFbEJaEns
        f3EDzOYXUJS4+uMxI4jNK2AnMWPaHiCbg4NFQFXi2rFCkLCoQJjEyW0tUCWCEidnPgG7m1PA
        QeLEt0tg1zELiEvcejKfCcKWl9j+dg4zyF4JgQscEsv2dTFBvOAicfjYdihbWOLV8S1Qr0lJ
        fH63lw2ioZlRouHFbUYIp4dR4uizPhaIKmOJ/UsnM4FcxyygKbF+lz5EWFFi5++5jBCb+STe
        fe1hBSmREOCV6GgTgihRlrj84C7UXkmJxe2dbBMYlWYh+WcWkh9mIflhFsKyBYwsqxjFUguK
        c9NTiw0LTODRnZyfu4kRnIq1LHYwzn37Qe8QIxMH4yFGCQ5mJRHef7+Nk4R4UxIrq1KL8uOL
        SnNSiw8xmgIDeCKzlGhyPjAb5JXEG5pYGpiYGRmbWBiaGSqJ8/ZOPZ0oJJCeWJKanZpakFoE
        08fEwSnVwFRwf8G3MPnlAhoqP/a3JcR7TJzK9Y/z3NeYmmYOU7UZJ6s//CjLLF71d1PfySym
        vbFJ8pKy4Qu8omWnaJ1fdcCzdUmCk6SJo3J008MqxsIJjxcvm2u1Y1W1lv6r6c/vVv8+s+K1
        8Jyj8UqTr2xdzlTv36p05dGNIHMXqedHarvjrnbM2Ncn+FNPJlW55qLO6+vrn3J9fb/2s1HU
        Bc2SYttVpemnK92Sq+eY/5u6l9N0tYx3Rf6FtPYsK1c9zwepIuVvzcSjHmi2eeW/6tk9uTfh
        aceeAC3P2slxV/QONXy9JfBsU9HUg/mKFUlzu2ynP2R5tvSzUszEfeLyG38tbXHVviRVlXXQ
        V3meOkv6QSWW4oxEQy3mouJEABK45UlOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvO6Et+ZJBvcO2Fhs+vie1eLV5j1s
        FvOPnGO1+P/oNavFjw2nmC3ONr1ht9j0+BqrxeVdc9gsPvceYbT49OA/s8XtxhVsFq17j7A7
        8HjMbrjI4rFpVSebx+Yl9R5/Z+1n8ejbsorRY/u1ecwenzfJBbBHcdmkpOZklqUW6dslcGWs
        //+bueCZeEXzpSvMDYwtwl2MnBwSAiYSzze9YAWxhQR2M0qsPOoHEZeUmHbxKHMXIweQLSxx
        +HBxFyMXUMlbRonlfxYwgdQICzhJTHq7kRnEFhE4ySix4pUQiM0s8I5RYuH3LIiGyYwSbw6f
        AGtgE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE5ixrQ9jCDLWARUJa4dKwQJiwqESexc8pgJokRQ
        4uTMJywgNqeAg8SJb5fYIXapS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMwrOQtM9C0jILScss
        JC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx6OW5g7G7as+6B1iZOJgPMQo
        wcGsJML777dxkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTByc
        Ug1Mez4HP5mq+bIrXNRWLkj5trvPKsNFZ2UDu3mzJT77V/yrr5N5nekkJPo2pa3uxoVbAT/m
        3ll1Rkwpwln98+TGOydZxeTbNEuzDx0XfWT68YH13puBNelNC4Tj6x3u763LWBN37/JE6Z/v
        GB7civp6+/vM/QJLxIolH5m6zQjkuXSqvt1uxYRtkU61p8zM//1Y5mSZvE/eXH/TiUtJWeUq
        CQoF4ssrI37Uv8jOKe0QnNrxgtGvtCFkzmuZAIZzvx9+36d0oe6ttPmk5btlLxUJ7ImZZ3el
        LeY0N2tCvEOh3eFj2i8uez0WU//91dRox//+Hw8lflV+XHbnXGvelGUN23LuRE6KX/Y+btqc
        PF03JZbijERDLeai4kQAdAGeuTYDAAA=
X-CMS-MailID: 20220321031425epcas1p21cc0552e9712818d95b39747cfc3166a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308190916epcas1p1baf4361cc5f33a90b38b01be7ffa748d
References: <CGME20220308190916epcas1p1baf4361cc5f33a90b38b01be7ffa748d@epcas1p1.samsung.com>
        <20220308190901.3144566-1-briannorris@chromium.org>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,


On 3/9/22 4:08 AM, Brian Norris wrote:
> This series covers 2 primary tasks:
> 
> 1) Resubmit prior work:
> 
> [RESEND PATCH v5 3/4] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
> https://lore.kernel.org/lkml/20210308233858.24741-2-daniel.lezcano@linaro.org/
> [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> This series was partially merged a while back, but the remaining 2
> patches were blocked mostly on stylistic grounds (alpha/numerical
> ordering).
> 
> 2) Integrate many updates, bugfixes, and clarifications that were done
> by Rockchip and Google engineers when first launching this platform.
> Many of these were not integrated in the earlier series (e.g., the OPPs
> changed before production; earlier patchsets used pre-production
> numbers).
> 
> Along the way, it seemed worthwhile to convert the binding docs to a
> schema. Among other reasons, it actually helped catch several errors and
> omissions in translation between downstream device trees and the version
> that actually landed upstream.
> 
> See the patches for further details.
> 
> Regards,
> Brian
> 
> Changes in v4:
>  * Update .yaml to use more "default" entries, instead of free-form text
>  * s/phandle-array/phandle/
>  * Move to .../memory-controllers, update filename
> 
> Changes in v3:
>  * Add |maxItems| for devfreq-events
>  * Improve deprecation notes
>  * Add Reviewed-by tags
>  * Collect some Acked/Reviewed tags
> 
> Changes in v2:
>  * Fix yamllint issues
>  * Adapt to various review comments (use of *-hz, hyphens, node naming)
>  * Add a few new bugfixes
>  * Add some new properties (ported from downstream kernels) required for
>    stability
>  * Convert more properties from "cycles" to "nanoseconds"
> 
> Brian Norris (13):
>   dt-bindings: devfreq: rk3399_dmc: Convert to YAML
>   dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant
>     properties
>   dt-bindings: devfreq: rk3399_dmc: Fix Hz units
>   dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
>   dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
>   PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
>   PM / devfreq: rk3399_dmc: Drop excess timing properties
>   PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
>   PM / devfreq: rk3399_dmc: Support new disable-freq properties
>   PM / devfreq: rk3399_dmc: Support new *-ns properties
>   PM / devfreq: rk3399_dmc: Disable edev on remove()
>   PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
>   PM / devfreq: rk3399_dmc: Avoid static (reused) profile
> 
> Lin Huang (2):
>   arm64: dts: rk3399: Add dfi and dmc nodes
>   arm64: dts: rockchip: Enable dmc and dfi nodes on gru


Applied them except for patch11/patch12 about dts patches.

Thanks for your work.
Chanwoo Choi




-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
