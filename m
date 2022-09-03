Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40E5AC0D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiICSkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiICSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:40:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02B27DCF;
        Sat,  3 Sep 2022 11:40:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 72DE65C00F2;
        Sat,  3 Sep 2022 14:40:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 03 Sep 2022 14:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662230431; x=
        1662316831; bh=piNgzvHSj4JEWJsVB08bq+orA413gDpxIity4wOa2Lc=; b=K
        V4w0Xr4pHx9XO0eiVFm/ibG6sXKB+EpNtkkNTYDBPy8H3CoXgTNpPyAnsA9vih5t
        VcGitEUs0FkdFCCtAlIln0f+ebm+FZivwVTG6GmUN93xYx/hQXgBShU2DpxERjZI
        Yytjzp+3R8ch5IBrcdiFsFw/90aV/O46zqWa/KgMIxT29j9Wa8AWi8qwBPfS1gDr
        gzF8bIsbK6YOx+Tn+eW4C/+acm6CekLuv0kxZ00iiwP7dlMRgFdmUvxKIID+Mpm7
        GbGJgFXZZLgpSTv/1odC9pjzZYJ1J2KZhTQm572kMEvKch2JQA74niFdpadcaYsS
        fekLEYMYJOwykdbw8Qtfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1662230431; x=1662316831; bh=piNgzvHSj4JEW
        JsVB08bq+orA413gDpxIity4wOa2Lc=; b=p/g2XW67O22lzgEmKvEk7PGCxtMqa
        zubW9iITdsSBSVP0Mc67WR/u0IF4Mxb6IIT4VAMC+trWWdLcucsnn+/Xj878wJ+Q
        3vHzeHw6IGIc5AVMwt3/8i/a20VMOL6vGFSiOLAGXaTj72ZQhkw4rqbYgMrLEeSv
        UxKacvvg51hyE8BQCBU1qSp7jtwutguUkngPoeyUepxQfA67KTDXHh0rtk7NFQHj
        rSzxvaXjcaAXmgvpux08z8OPgxs88lMYXBb/mwAhEvPVr1/MHPYNM+Mf10CAPprj
        zMH0jp+CK3pw8fjhqpAIMVR4ypWu6B9NTSOEg+LelW9Cur/4Rsp/KvIZQ==
X-ME-Sender: <xms:n58TY7F_DlevC79ofiY35pqaqkqWnmBf0_uiFtvk19SPJw_U3qPdWg>
    <xme:n58TY4WAB5VEtq5vw7ZpE4pcLisRyEZOnV7oQ9cm-upVuK7Aje8Hc_W0OLbH46a3M
    kIm9IP6fSbFc_MKGDo>
X-ME-Received: <xmr:n58TY9KOpfmu7bFleL5qhO5E145xT9402q1A9omESIKPSb7YhQUd163dpTfn-WjXqEbXYvyOYgLHCd6CuxEO6ucVi3-hIf-1RJe7cX1E4v-jh98JqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgig
    ucfhihgvrhhkvgcuoehmrgigsehmrgigfhhivghrkhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduleevvddtfffhuefgleeiveevvdehgfevtdetfeekvedvhfeikeduueetfeeg
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igsehmrgigfhhivghrkhgvrdgtohhm
X-ME-Proxy: <xmx:n58TY5HnSRTgXRpoQd1k8LzGOlsM8gQj9OBOJkHVpkEeOXCh-JlBtg>
    <xmx:n58TYxWjc31eS45eU8M4sv9Rc-4iHSC3q0gHnUFAePizJfU4e-_rBg>
    <xmx:n58TY0PqA13p9YqajkE0sLippM3OLkjWdW1w0T3GHwcHSPYzshOspA>
    <xmx:n58TY2WZy9DLBmH5k3cZ82mikJ4vyxUQ4FrkCrM2pzcMK0cEt0r-OQ>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 14:40:30 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for ClockworkPi
Date:   Sat,  3 Sep 2022 13:37:50 -0500
Message-Id: <20220903183753.25736-2-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903183753.25736-1-max@maxfierke.com>
References: <20220903183753.25736-1-max@maxfierke.com>
MIME-Version: 1.0
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

Add a prefix for Clockwork Tech LLC, known as ClockworkPi. They
produce a number of hobbyist devices, including the ClockworkPi
DevTerm and GameShell.

Signed-off-by: Max Fierke <max@maxfierke.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 7a326168d1d2..b9cf4f02c362 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -254,6 +254,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^clockworkpi,.*":
+    description: Clockwork Tech LLC
   "^cloudengines,.*":
     description: Cloud Engines, Inc.
   "^cnm,.*":
-- 
2.37.1

