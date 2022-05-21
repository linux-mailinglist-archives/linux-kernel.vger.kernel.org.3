Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D859B52F76D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbiEUB45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiEUB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:56:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A922340EF;
        Fri, 20 May 2022 18:56:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w17-20020a17090a529100b001db302efed6so9148518pjh.4;
        Fri, 20 May 2022 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QSpdu/egxZKM3RI4Cm6qIa5QbmxuKJHaffE0Voql3CE=;
        b=n+FCuihC/ER3eImgCgVl3ISMdL+95BNlaHQw2lyKmlIWK0/C9MflJZI4U1bkGDVOpb
         2Y9d9Q2wCR0VGI14/T6bU8wFszFL0MsWZLtTRwYp09WuvUAfy7f3Lx2Ngvg1ApFtUUJM
         XLe4MXpetTLfTrLksxd1C3bOPSywH9oiSVCXw8zFn0q0ygk3qJluuoYxQk18Vz7bEx6m
         m5oZPk/H+5naWH7V7TYaDBstM+WVxYlnRLXuSejjhSCjNEhtJdHGwAV9VfAM05Zm7jwE
         Xg4TAgoAdkxuFrqEWAeZ/ooJVllGKV/pHsyAyn+TrGKOOtK6EJr7D6dTuedpX7qnqWK9
         bJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QSpdu/egxZKM3RI4Cm6qIa5QbmxuKJHaffE0Voql3CE=;
        b=e78KLueaO4D4+bj8hJC4gpRR8f7cg8AYpSfMS8x9hcIC7jk/RjfEGHebVmMAohINeK
         saBmzzKVXeXqH/dpRZ4vZEOPwOhd90AhoC+KUHCfhdlpm03MeboxPlKhYDldv+ts/gp/
         gF+x7Ds4Vzvt2JDJcpkfVT+YpCMjp6ds61kxnNfv39uPFOfAaTEc3KjeKMNkk9Y0mZD1
         DybVNtu0ZVM4rmU7h3GNtqi6AVM8362wVBhOHSupG36jO1GHmrTwjO+YYmA5rCG2eKwI
         YSL1V9U7Y2IAhrcwSb3Enjys1l50jymXkmnWp/VYZwoJcsRB4LKCUR/4Inv6ZXefNhIq
         uBgA==
X-Gm-Message-State: AOAM533fRD9ve24brAtMohEMzjdeJEC/g/TGil7CT628sAnCBydCgTZu
        AnETUR47tkJM9XVSiZGePA8UCFRhFx+9gA==
X-Google-Smtp-Source: ABdhPJwB33uNJRdpq/U3R+hTLr5qXtUv3ydzsK2RhgBiLI9R27LrrZiyuE+0kc4bRBlkBq6A88c6Ow==
X-Received: by 2002:a17:902:ce87:b0:15e:a619:4294 with SMTP id f7-20020a170902ce8700b0015ea6194294mr12482580plg.157.1653098211441;
        Fri, 20 May 2022 18:56:51 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm2381525pfe.218.2022.05.20.18.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 18:56:50 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Date:   Fri, 20 May 2022 18:56:13 -0700
Message-Id: <20220521015613.6197-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts .txt documentation file to ReST format(.rst).

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst

diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.rst b/Documentation/devicetree/bindings/mips/cpu_irq.rst
new file mode 100644
index 000000000000..601cc12caa2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cpu_irq.rst
@@ -0,0 +1,56 @@
+=============================
+MIPS CPU interrupt controller
+=============================
+
+On MIPS the ``mips_cpu_irq_of_init()`` helper can be used to initialize the 8 CPU
+IRQs from a devicetree file and create a ``irq_domain`` for IRQ controller.
+
+With the ``irq_domain`` in place we can describe how the 8 IRQs are wired to the
+platforms internal interrupt controller cascade.
+
+Below is an example of a platform describing the cascade inside the devicetree
+and the code used to load it inside ``arch_init_irq()``.
+
+Required properties
+-------------------
+* compatible: Should be **"mti,cpu-interrupt-controller"**
+
+Example devicetree
+------------------
+::
+
+	cpu-irq: cpu-irq {
+		#address-cells = <0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: intc@200 {
+		compatible = "ralink,rt2880-intc";
+		reg = <0x200 0x100>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpu-irq>;
+		interrupts = <2>;
+	};
+
+
+Example platform ``irq.c``
+--------------------------
+::
+
+	static struct of_device_id __initdata of_irq_ids[] = {
+		{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_irq_of_init },
+		{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
+		{},
+	};
+
+	void __init arch_init_irq(void)
+	{
+		of_irq_init(of_irq_ids);
+	}
-- 
2.17.1

