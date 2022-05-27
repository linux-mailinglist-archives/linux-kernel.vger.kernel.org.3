Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FE53580F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiE0DfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiE0DfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:35:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326591570
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:35:00 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220527033458epoutp02c1a1106adfd00ad5efc2b303faf9ef99~y2OaYzNAX2339423394epoutp02f
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:34:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220527033458epoutp02c1a1106adfd00ad5efc2b303faf9ef99~y2OaYzNAX2339423394epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653622498;
        bh=C56Kmrrcot59L72Jh6NNgirPvZtuEzfeiL7AUW9Vf3k=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=qSXLkrKOI//98tOonMwsg2I3AEXouNkEYf0agnxhwt6o5rRNATwBVDEyR93RITgJW
         xlH2EgmGMg8MWRgHaO5MKNrEpqf9qS6JRDryLpTYGp3jH5arMBGS4dDJYPqqqxgr8c
         IB8Zhn4uC78Y2G5ubfw8wUuKZ1AqyEYM40RIpMo4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220527033457epcas2p370bdfcd2843830dd13147ef6a03f1d81~y2OZhoLWB2053320533epcas2p3o;
        Fri, 27 May 2022 03:34:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L8Vmb65Vbz4x9Py; Fri, 27 May
        2022 03:34:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.9E.10069.FD640926; Fri, 27 May 2022 12:34:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220527033454epcas2p144713ba96c36ad13d423c5520005f4a1~y2OXbnJaK2828928289epcas2p12;
        Fri, 27 May 2022 03:34:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220527033454epsmtrp17092120e83fe7d4a21f8e7374908d909~y2OXav2X90251702517epsmtrp1d;
        Fri, 27 May 2022 03:34:54 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-5a-629046dfd6a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.AA.11276.ED640926; Fri, 27 May 2022 12:34:54 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220527033454epsmtip2f29dd3c0e9d438a74d90db98b89bb132~y2OXNY_3-1735817358epsmtip2K;
        Fri, 27 May 2022 03:34:54 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
In-Reply-To: <20220526143707.767490-6-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 5/7] arm64: dts: exynos: use local header for pinctrl
 register values
Date:   Fri, 27 May 2022 12:34:54 +0900
Message-ID: <011c01d8717a$bb2f2ed0$318d8c70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJyxhdZ1KlViaDZ4SOc3qllW0JPVwGGcubRAfWMyjWr4YgFYA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmqe59twlJBnefaVs8mLeNzWL+kXOs
        Fn0vHjJb7H29ld1iyp/lTBabHl9jtdg8/w+jxeVdc9gsZpzfx2TRuvcIu8XhN+2sFqt2/WF0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ8zff4OlYD1bxd1ZZQ2MPaxdjJwc
        EgImEs8vrgayuTiEBHYwSqxb8pQZwvnEKLH90nEo5xujxM+1IA4HWEvHiRyI+F5GiRPv17BA
        OC8YJR48v8kEMpdNQF/iZcc2sB0iAp0sEr/6XUBsTgFXiX+XDzOD2MIC0RITtzQxgtgsAqoS
        z85sB7N5BSwlHvUsgrIFJU7OfMICYjMLyEtsfzuHGeJuBYmfT5exQsRFJGZ3tjFD7HKSONLw
        mg3kIAmBLRwSGx52M0E0uEhsm/QJ6mlhiVfHt7BD2FISL/vboOxiiaWzPjFBNDcwSlze9osN
        ImEsMetZOyPI+8wCmhLrd+lDQkJZ4sgtqNv4JDoO/2WHCPNKdLQJQTSqSxzYPp0FwpaV6J7z
        mRWixENi+Ru5CYyKs5A8OQvJk7OQPDYLYe0CRpZVjGKpBcW56anFRgWG8KhOzs/dxAhOvFqu
        Oxgnv/2gd4iRiYPxEKMEB7OSCO+Fp71JQrwpiZVVqUX58UWlOanFhxhNgcE+kVlKNDkfmPrz
        SuINTSwNTMzMDM2NTA3MlcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUw+YioX3u7SqZxdci8
        ivkWLB/fTTy4Ma/k7jrlhZPXBScbV0RZOu+a9vLs2Wln7s18Jl7Cc+n2w7m1TRG1EkKzTVUm
        z9/uKivHwVDtp3pLIbuqaNWibWUHju5eq/f7QF6GgeQDt1amO+3alyYZ+O4R/LeMy2xS7tpp
        kWeKLJhd4x8XGiy6UPFsz+7AczVaVw+uX3V6FZfS+x15ZQnVKw9r2xS/8q0Vm5n0t45P9vrL
        rcuydhluqOi/P9FaN9tg6uSddlZVe78Gtq54VMOjEnfq/t3E+hRxB9ejrseXO4XvTLyrMrXl
        o+Ur85AHHgcUz9rECDdFHCyNCpleeN1Zf7r6XjcBzhPG+YejTDcf5klNV2Ipzkg01GIuKk4E
        AFAymQJFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvO49twlJBt/3G1k8mLeNzWL+kXOs
        Fn0vHjJb7H29ld1iyp/lTBabHl9jtdg8/w+jxeVdc9gsZpzfx2TRuvcIu8XhN+2sFqt2/WF0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qNvyypGj8+b5ALYorhsUlJzMstSi/TtErgy5u+/wVKw
        nq3i7qyyBsYe1i5GDg4JAROJjhM5XYycHEICuxklWl5qgdgSArISz97tYIewhSXutxwBKucC
        qnnGKHFt2x0mkASbgL7Ey45trCC2iMBEFomrKxIhis4zSvxZ9xusm1PAVeLf5cPMILawQKTE
        h+Nb2EBsFgFViWdntjOC2LwClhKPehZB2YISJ2c+YQGxmQX0JNavn8MIYctLbH87hxniIgWJ
        n0+XsULERSRmd7YxQxzhJHGk4TXbBEahWUhGzUIyahaSUbOQtC9gZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREcbVqaOxi3r/qgd4iRiYPxEKMEB7OSCO+Fp71JQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCt4LnmzHO5LOTIVFauMqPV
        Ef4nXmTzvtflF5mrVdFw4rCFiW9ZsooQY0PMhfdTiuQbn/6ZN0HT8fnXskebTMMck8pWbg+v
        rY1amPzc3fXsIS3jr5HnyjaV9m3/EHxz4em/fLtTtn9uXxr8TZlX7+K5l9yHmfbIvTOPj/v1
        656bW3vIvRVHliRc7D4gKm9YcPmdj3bW1QMeDMuDP3mu3bL2gdeF3Yu8vFWP/ckTbv/g7Ce7
        Y3faNt26hpfTD7bZhsht19ZezjDrkL2ulQCnek3v2V3qhcz8kf4qjwpqHAO1uTprF4n2qn2e
        bV9i0fr5HYtb6GT3rjP/qkQSG1O7+4QPfRDOnjLnQqVw5HHeI0osxRmJhlrMRcWJAKDJXkMl
        AwAA
X-CMS-MailID: 20220527033454epcas2p144713ba96c36ad13d423c5520005f4a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526143747epcas2p207eb53176b26848e39065cf5c56a9798
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
        <CGME20220526143747epcas2p207eb53176b26848e39065cf5c56a9798@epcas2p2.samsung.com>
        <20220526143707.767490-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 5/7] arm64: dts: exynos: use local header for pinctrl
> register values
> 
> The DTS uses hardware register values directly in pin controller pin
> configuration.  These are not some IDs or other abstraction layer but raw
> numbers used in the registers.
> 
> These numbers were previously put in the bindings header to avoid code
> duplication and to provide some context meaning (name), but they do not
> fit the purpose of bindings.
> 
> Store the constants in a header next to DTS and use them instead of
> bindings.
> 

I also verified before & after using dtx_diff tool and booting & pinctrl
value dump on my exynosautov9-sadk board.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

