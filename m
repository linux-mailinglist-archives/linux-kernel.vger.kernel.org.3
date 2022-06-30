Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62356171B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiF3KDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiF3KCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:02:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2343EDE;
        Thu, 30 Jun 2022 03:02:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D8E85C02FA;
        Thu, 30 Jun 2022 06:02:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Jun 2022 06:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656583368; x=
        1656669768; bh=rukFsKCtzvuRkbG83MFab30lodzeGqZdlWa/kvg1r5s=; b=Z
        EMEv2BBGFfuf6awEWncvn0trs5PXyggT8N4vSiYYnMz+nYW5ncjVNj3bLucMp0zQ
        O1sIAbxLYqn1AYdSLjm3A6k5JJW4gpAZMKCH9GnXRioJjyX2c5sb7tQQFFrlzgcZ
        y2IEN09y/tc6P4RwhDkebnJ7xt9hFpjcwD7bbYjOuwoQizjZ0Tbzp0Kf/dACWHP9
        /ucYsmi/MQaeD0jyGJq9iBLk5P2u8DhCsJxrHNdd4QdsU0kQbl9n+B6HsVEFe3Pl
        zVWlyCquv1AySqSQ2tgehy1yCxfdXCTHvSpmW1gHiPW8eNwEUv5xWk8j7Gdzf+OH
        54eS7IIr++TePJ043ONBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656583368; x=
        1656669768; bh=rukFsKCtzvuRkbG83MFab30lodzeGqZdlWa/kvg1r5s=; b=s
        J77aMr1PK2JwSDE0Q1JpiW+pkh58ufaITM8Gv8+ao9ZgsUEdWWGdbdOtUT6EDDmi
        /4IpuL0YEYBHoN0tRFWjqieKleXqtlVym/iGqmC/aBU4djWnXNNg+S432FRbnMbJ
        akurfl5HBhOcieBsdhSSgH8sVDsDutoW80NIIk995tdkZ3CKSGM7SZ5lJfFHrrZ+
        YVa0FsUoAXTwidiBfgfkjPQ9PVHjU3AJJWhPI+5jFXY9azuHj9EbOKqzqnnZXvG8
        1PttTQaD1/y5I3cPibh0yvwkuuR6Y4fM+8wLRAVxFxLVN1DgYSvMwSMa5/qJwOLj
        qpUZPsBFcTRpUOzldQW7Q==
X-ME-Sender: <xms:x3S9Yqog83lhQWxJoDUD4-KX1djloJrYVoYsNvospCB9uQzTop2WnQ>
    <xme:x3S9YorAiyyq5lWZhX88xMuoObvNlcXqKuU8zShAZFSbAxF5BFwmTwnNqXRchWKIY
    M7HhPdC58HEUoQMSg>
X-ME-Received: <xmr:x3S9YvNOFamXUagJ9Jx5-2HtvN9GrgbSZ66sy--SALsuIVqPc9CH7xUvNwY9x6OFnFTCvEJxAaOVbYF7Gi9_LbXK9cjFZX4cXNn5IpmOmc3pHs7stj801GTiOXjogI3cyXaWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefueevueeffeelheelhfelgeelgffgieekffevteefveejueei
    teeugfefieehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:yHS9Yp5b6OnPMvf9gccnyecyMdPRYDRJDEzJeh9BAFuXf88yezSXww>
    <xmx:yHS9Yp66KhBENlqBPMrfa6hXaae3Kg4IhUUmMp6aByJhdTAS_C_LbA>
    <xmx:yHS9YpgFatQr0MzobHraY-EQUl1e8xbcMDMh3SDowkPzxANQPp8C4g>
    <xmx:yHS9YgowBalQ8_8eWN2CCy9LD1CxGX9XGdjJN-Lyjo2Pu8xEjusPvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 06:02:47 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/4] dt-bindings: interrupt-controller: Require trigger type for T-HEAD PLIC
Date:   Thu, 30 Jun 2022 05:02:40 -0500
Message-Id: <20220630100241.35233-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630100241.35233-1-samuel@sholland.org>
References: <20220630100241.35233-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V PLIC specification unfortunately allows PLIC implementations
to ignore edges seen while an edge-triggered interrupt is being handled:

  Depending on the design of the device and the interrupt handler,
  in between sending an interrupt request and receiving notice of its
  handler’s completion, the gateway might either ignore additional
  matching edges or increment a counter of pending interrupts.

Like the NCEPLIC100, the T-HEAD C900 PLIC also has this behavior. Thus
it also needs to inform software about each interrupt's trigger type, so
the driver can use the right interrupt flow.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Rebased on top of the RZ/Five patches

 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cd2b8bcaec3b..92e0f8c3eff2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -33,7 +33,7 @@ description:
   it is not included in the interrupt specifier. In the second case, software
   needs to know the trigger type, so it can reorder the interrupt flow to avoid
   missing interrupts. This special handling is needed by at least the Renesas
-  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100).
+  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100) and the T-HEAD C900 PLIC.
 
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -112,6 +112,7 @@ allOf:
           contains:
             enum:
               - andestech,nceplic100
+              - thead,c900-plic
 
     then:
       properties:
-- 
2.35.1

