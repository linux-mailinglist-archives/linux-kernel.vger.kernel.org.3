Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D291581D61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiG0CCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiG0CCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:02:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7A3C14E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:02:05 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220727020200epoutp01989d4e3bd81c77c0def74948e06c36b3~FjTqa2IoU2971729717epoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220727020200epoutp01989d4e3bd81c77c0def74948e06c36b3~FjTqa2IoU2971729717epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658887320;
        bh=6nt1G4G3WvranLna53VBA7SVbk0EDlra7toYUG7rBuA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oje3rUGnqFx8uG4JC+QObpOcm24nv1brnyVXRqZ9pRmVsSyDxYriFSNPC9gmkqM6N
         75U34M9l2nZHUvsxb4+3bosJh5Hm6nK9rDxOUrijsoGHRc5M+tVL6lKZVn9los3Z25
         PDRMVmQH+pXsbXl8+XvPogemoAMXQ47ZCZA1z59s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220727020200epcas2p46ff1f76b46df6b58bcf384d4f88734b4~FjTp5R9A12513025130epcas2p4X;
        Wed, 27 Jul 2022 02:02:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LsxqC3Wvxz4x9Q5; Wed, 27 Jul
        2022 02:01:59 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.F1.09642.69C90E26; Wed, 27 Jul 2022 11:01:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220727020158epcas2p4c326f1a1342f939f1ee23ac573ba3f0e~FjTocwNfx3185031850epcas2p4D;
        Wed, 27 Jul 2022 02:01:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727020158epsmtrp2373cf60bdd96d0eaf64b600b1ecf7dd7~FjTobmWAx1302713027epsmtrp2L;
        Wed, 27 Jul 2022 02:01:58 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-5e-62e09c96cb2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.16.08802.69C90E26; Wed, 27 Jul 2022 11:01:58 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727020158epsmtip1a95aa0e69c4d99f3cdc2513d3f837312~FjToOUIh21205012050epsmtip1k;
        Wed, 27 Jul 2022 02:01:58 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Saravana Kannan'" <saravanak@google.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>
Cc:     <kernel-team@android.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20220727013349.3056826-1-saravanak@google.com>
Subject: RE: [PATCH v1] pinctrl: samsung: Finish initializing the gpios
 before registering them
Date:   Wed, 27 Jul 2022 11:01:58 +0900
Message-ID: <000001d8a15c$da89d980$8f9d8c80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKDghdYfyUFZdNhjAU1XAi4XeJOwAIqlEK5rCpf/UA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmhe60OQ+SDBZvNbV4MG8bm8WO7SIW
        e19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLGef3MVkcftPOatF16C+bxapdfxgduD227d7G
        6rFz1l12jwWbSj3uXNvD5rF5Sb1H35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64tWs2U8E9lorjzx+xNjC+Zu5i5OSQ
        EDCReHrrLFsXIxeHkMAORomPT14wQzifGCWWNv5hh3A+M0qcX76LHaZlxt+JjCC2kMAuRokz
        x0Ig7BeMEgsfO4HYbAL6Ei87trGCNIsILGaS6NqxGmwss8AaRokvT3exgVRxCthI7H9/EOwQ
        YYFEiTc/VzCB2CwCqhLrHh4Gs3kFLCVO/V3NBmELSpyc+YQFxGYWkJfY/nYO1BMKEj+fLmMF
        sUUErCQen5/JDFEjIjG7sw1ssYTAAQ6Jm4f+Q73gInHm7FNWCFtY4tXxLVBxKYnP7/ayQdjF
        EktnfWKCaG5glLi87RdUwlhi1rN2oP85gDZoSqzfpQ9iSggoSxy5BXUbn0TH4b/sEGFeiY42
        IYhGdYkD26ezQNiyEt1zPrNOYFSaheSzWUg+m4Xkg1kIuxYwsqxiFEstKM5NTy02KjCGx3Zy
        fu4mRnDq1XLfwTjj7Qe9Q4xMHIyHGCU4mJVEeBOi7ycJ8aYkVlalFuXHF5XmpBYfYjQFhvVE
        ZinR5Hxg8s8riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cC0MYVt
        l2ayO6v21LRw9mcdJa462yMXrSjUvqL4ty83vyzGn1mssG3Sx0UfueUkd19sOqd76/f9w3EC
        oSs4SuuzbsuuFamdLLJMyzp+zrt1n24kPfqt+Tur+viKdW2Nh/TfNZzxv/bzRNKtrLz0+XWZ
        feFiDftUtY4wq7L/jzBl+neUKe7hvWeMWxZOufzKaEvkmYiyy3XOURPte5btWn3v2ope/tgt
        us7JpdZ/BZnq40KMTlssuXjMJkgqLyLkY08J7/e62yVeHu1zmj3rp4Rr914+O7HQPNHz9i4F
        raumG/Ld/p75GVfxcl5GGnt5dNgNLWb7/Iq+pbNWlLtrXtDKtBV62/Xm5/a5TJ5v1JVYijMS
        DbWYi4oTAbaPyNFGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO60OQ+SDH48E7V4MG8bm8WO7SIW
        e19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLGef3MVkcftPOatF16C+bxapdfxgduD227d7G
        6rFz1l12jwWbSj3uXNvD5rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZdzaNZup4B5L
        xfHnj1gbGF8zdzFyckgImEjM+DuRsYuRi0NIYAejxJnvl5ggErISz97tYIewhSXutxxhhSh6
        xiixa956sCI2AX2Jlx3bwBIiAkuZJJb3z2cDcZgFNjBK/OmczwLR0ssocbh5AytIC6eAjcT+
        9weBlnNwCAvESyzsBbuDRUBVYt3Dw2BTeQUsJU79Xc0GYQtKnJz5hAXEZhbQlnh68ymULS+x
        /e0cqB8UJH4+XQY2XkTASuLx+ZnMEDUiErM725gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC
        4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOBI1NLawbhn1Qe9Q4xMHIyHGCU4mJVEeBOi7ycJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwMT5yYN7cdzz
        ywXGJzOPzTL8EZ/kr1ET9tHDi7d5WWqFYuyiL24zpL+b3M908flWyv7RJph9x8SaLYqLlZKb
        A5QKWlbxW7orLbUrYuf/9UywQkdTfGpWZ0URu37tmUM3Y75MSD67IairZcmKOzuuec0LuLfC
        cUmAfYeIo05G4RPxy3f9HnhFhs/xs5t17Nn0X2yuHIcOH20zrjK0lWvSnPyFq2LmUv9bObmX
        LyryHuRV2HFa8GTG7A4J5nK9j+U7Oa2tz4gf7Jw0L6u0MMGfOf5Ljk5Z15fdS06c/Fa+e+5D
        F9P/UwTCtsk+VYydd1D9O8Pi6IMxJRMK1Rj/RmwIN3z/XfqMw8QLjEu2aW4/qsRSnJFoqMVc
        VJwIAIVoldQzAwAA
X-CMS-MailID: 20220727020158epcas2p4c326f1a1342f939f1ee23ac573ba3f0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727013403epcas2p452b5f66597b4298b7a573393927ac96e
References: <CGME20220727013403epcas2p452b5f66597b4298b7a573393927ac96e@epcas2p4.samsung.com>
        <20220727013349.3056826-1-saravanak@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1] pinctrl: samsung: Finish initializing the gpios before
> registering them
> 
> As soon as a gpio is registered, it should be usable by a consumer. So, do
> all the initialization before registering the gpios. Without this change,
> a consumer can request a GPIO IRQ and have the gpio to IRQ mapping fail.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Make sense for me and I tested this on my Exynos Auto v9 SADK board.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

