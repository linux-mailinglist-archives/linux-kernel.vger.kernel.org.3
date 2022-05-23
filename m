Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DA531660
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiEWSMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243686AbiEWRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:42:23 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A399E9FE;
        Mon, 23 May 2022 10:34:20 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220523173241usoutp029eb833155efa9a452e6edc55a6789a33~xzEsh8v_Q0898108981usoutp02U;
        Mon, 23 May 2022 17:32:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220523173241usoutp029eb833155efa9a452e6edc55a6789a33~xzEsh8v_Q0898108981usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653327161;
        bh=HEfKl/NdTKSQGo39X2HbhKmB5mTaxUlPRuEMKR2+IH4=;
        h=From:To:CC:Subject:Date:References:From;
        b=EJ24G8MUIhxoL6zw7CYlzZoN9IGvWpIbRPyK0qzc+FBxerHJJUXj+RtHgtwMtYu4K
         1Ik5TSTppp11+BVHiTYgYeCSmiKScTY+RsoTB/0ivbdPc2aKEjVu47nJ9xFmBRUhzZ
         ToKAAQJO3V3jI+8a9LPHWMEdsawFmLZjQ3yO8hjA=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220523173240uscas1p2022e4f537d4ef75e00ad54f8e4bc1d12~xzEr6-rYq0794907949uscas1p2Y;
        Mon, 23 May 2022 17:32:40 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 79.56.09642.835CB826; Mon,
        23 May 2022 13:32:40 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523173240uscas1p10a3b4a1eb034af351bb726cce48bc1f6~xzErtFZ9K3215732157uscas1p1K;
        Mon, 23 May 2022 17:32:40 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-e4-628bc5389d21
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 2E.FB.52349.835CB826; Mon,
        23 May 2022 13:32:40 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 23 May 2022 10:32:39 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Mon,
        23 May 2022 10:32:39 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [ANNOUNCE] CFP: CXL Microconference - Linux Plumbers Conference
 2022
Thread-Topic: [ANNOUNCE] CFP: CXL Microconference - Linux Plumbers
        Conference 2022
Thread-Index: AQHYbssZbLXpAfi4tE2++gsNHiRkXQ==
Date:   Mon, 23 May 2022 17:32:39 +0000
Message-ID: <20220523173239.GB353513@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <821F680737C1394686B21DE39EFBA461@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVCLcRzA/fbs2Z6m1dPCvjhcW/0zrLxdj+Pycv5Yx0nOCXFZ9ahOqzxP
        Ia9ZJOt0UxdnJZVbinlboVG5ilCoztV6cXVcl5y3mRtCC3vmbv99vm/3/Xx/9yMwSRU+g0hK
        SaeZFHWyTCDi32l1dMynHuXFhnT1yamcK4086lxRJ6Ku9pkQ1WFo41Mv75UIqEHTBL5SoOo8
        dgtXXap/x1OZ7QVCVVHxUdVX8+wN+DbR8ng6OWkvzQSH7RQl3vw8hKU98dv/tsSKslCpjw55
        EUAuBmP5E0yHRISErEZQlW9EXHCCB1pdA+9/1yttO48rXENwxjEh4AI7gh+jZnelEkFF7TfX
        iIAMgV+Pb2H/eAq5CuqaHK4JjPyKoO3TeVyHCMKfjADLwEKuZxPYLjiFHCuhYeSz4B/zySAo
        Lf7myovJJdBuyXXlETkNvreZXLswUgr9wxfdqn5QUVyPcTwNnPdeCzgOgKHv74Rc/zwou28X
        cBwGn27ku3kuVJa/x7hdfvD0/DCfm50OTVW9bq4l4MuLWRyvgY6WPMTxTOi2FrkeEsiTCGz6
        RpwL9AhefRxzWywD56ket4UPjP98g/RIbvA4wuAhaPAQNHgIGjwEyxB+BUkzWFaTQLMLU+h9
        SlatYTNSEpRxqRoz+vuZ2p0tqXXI2v9F2Yx4BGpGQGCyKeK76txYiThenXmAZlJjmIxkmm1G
        Mwm+TCquTLqplpAJ6nR6N02n0cz/Ko/wmpHF285k8Z3a6r6H6Y5TXW/ZYzsCpXrKbpkXuceW
        mbesNH/OovCeXiEV51u1Inj9JObMIHlo6ZGRJnLCsiXmRc1AwomT0f6i3gOXTBKLZMMvxcbk
        qNP6utsHGcuI/KFUe3k8N9A7VjYa9Cb8rEo2XG8sTzNHbw28rpM/ZyLWbgqYSuiHakK9l6iy
        raH4Zo1Jo1yZE9uaZrdVi1XdusPWBYZCzWKbIn6sZvPgtvCG0dDxrVFxwln+uI1V5CimTux6
        pm3sD6ho/pCNCuU1FaNNuWLTgyi8JXikZ93v1mhR+W8fR4O921gwNNn36rWBTH326iIv7zmR
        xqey4zk7vIMmBcr4bKJ6gQJjWPUfB7aBnbsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cA0UdfiaHeSwaxzAhZtq/YxWUyfeoHR
        YvXNNYwW52edYrG4vGsOm8W9Nf9ZHdg8LjRuZPVYvOclk8emT5PYPabOrvf4vEkugDWKyyYl
        NSezLLVI3y6BK2PD+/vMBScEK57Puc7YwDiPr4uRk0NCwETiTtNppi5GLg4hgdWMEr3zdkE5
        nxglVvzZzwjhLANyHv1mBGlhEzCQ+H18IzOILSLgKLHj4Fc2kCJmgc+MElNWbmEFSQgL+Ers
        ObCfBaIoRGLiIZgGPYm9z96zgdgsAqoS82Z/YwexeQVMJU7v7ACLMwqISXw/tYYJxGYWEJe4
        9WQ+E8StAhJL9pxnhrBFJV4+/scKYStK3P/+kh2iXkdiwe5PbBC2ncS79X1QtrbEsoWvmSF2
        CUqcnPmEBaJXUuLgihssExjFZiFZNwvJqFlIRs1CMmoWklELGFlXMYqXFhfnplcUG+allusV
        J+YWl+al6yXn525iBMbo6X+HI3cwHr31Ue8QIxMH4yFGCQ5mJRHe7YkdSUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5hVwnxgsJpCeWpGanphakFsFkmTg4pRqYnIsENbLDhLalaf9oSFF9q277
        +LbV9aLKZVxHax8GHWmIalD7VX2Ov8t+/5bV+UfqJj1YJ39fJKN9jlJK8/lQoRVdTEGaR58c
        esBr2FT63PrHZq/mpIa8m2ver/X6oRf/KGfhZeZpHW/yf7y54+Ntucf0dU0b5/Ore1jjWjnL
        PLR+TLqc1paiNPO3ejXHV+V5W3Ue+Fxwdvx78s20aZc7cmuPPy49X7nUIGJmr2m/oozckjUm
        /Y3ygktO/935X7rdS+ViZGKa6+U79cbmvzru7eo7u+xY1S2/mVqPv6/aExL4K+LljqlH9rR4
        PHhod66yW20Rf9gXB4PWHdZ8TUddngftXM12u7XvzJewIyrpSizFGYmGWsxFxYkAEOshNUAD
        AAA=
X-CMS-MailID: 20220523173240uscas1p10a3b4a1eb034af351bb726cce48bc1f6
CMS-TYPE: 301P
X-CMS-RootMailID: 20220523173240uscas1p10a3b4a1eb034af351bb726cce48bc1f6
References: <CGME20220523173240uscas1p10a3b4a1eb034af351bb726cce48bc1f6@uscas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute Express Link is a cache coherent fabric that is gaining momentum in=
 the
industry. Several hardware vendors have begun to ramp up on CXL 2.0 hardwar=
e
development and the Linux plumbing needs to keep pace. There is foundationa=
l
infrastructure in place in the kernel, QEMU, and user tooling that represen=
ts
the beginning of the CXL enabling journey. However, there is more to do and
plenty of opportunities to scale the contributions past the initial set of
developers that got the CXL subsystem off the ground.

The Compute Express Link microconference focuses on how to evolve the Linux
CXL kernel driver and userspace components for full support of the CXL 2.0
spec (and beyond). The microconference provides a space to open the discuss=
ion,
incorporate more perspectives, and grow the CXL community with a goal that =
the
CXL Linux plumbing serves the needs of the CXL ecosystem while balancing th=
e
needs of the Linux kernel project. Specifically, this microconference welco=
mes
submissions detailing industry and academia use cases in order to develop u=
sage
model scenarios. Finally, it will be a good opportunity to have existing
upstream CXL developers available in a forum to discuss current CXL support=
 and
to communicate areas that need additional involvement.

Suggested topics:
- Ecosystem & Architectural review
- Regions
- QEMU support
- Security: IDE and SPDM
- Managing vendor specificity
- Type 2 accelerator support (bias flip management)
- RAS (GPF, AER, Poison handling )
- 1.1 to 2.0 compatibility
- Hot add policy, daxctl
- Hot remove
- Industry and academia use cases

If you are interested in participating in this microconference and have=20
topics to propose, please use the LPC CFP process [1], and select "Compute
Express Link MC" for the "Track".

The submission deadline is June 30.

Come and join us in the discussion. We hope to see you there!

For more information, feel free to contact the Compute Express Link MC Lead=
s:
    Adam Manzanares <a.manzanares@samsung.com>
    Dan Williams <dan.j.williams@intel.com>
    Ben Widawsky <ben@bwidawsk.net>
    Davidlohr Bueso <dave@stgolabs.net>

[1] https://lpc.events/event/16/abstracts/=
