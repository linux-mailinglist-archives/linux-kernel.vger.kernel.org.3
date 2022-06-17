Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60154F6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381729AbiFQLfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiFQLfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:35:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A265D03
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:35:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x17so5392161wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QiECGMyoabW1BzY8/U8FfTuZG7oydQSw4kJVVQOhsls=;
        b=FiC9YX/nAbiWwFkYmKpOz54nJ50Ftf90z4aTtvlcGqj+/6QntRRyuxKPuhsoglcm9p
         q5YZ3TzJf98VWsI/C1H0fFKox9rIp0Hu1WhWRaBet+pf2EVFOfqVWfAsebl5qazljZY6
         fIhRnva8H04pMSBkSnflkePOcEQPlPUJIxm9ctbeGfTZbLm8glEVUDyIerWmpCArGuWq
         +CDARcAtAfeOxpF5xqajIeHt2Hc1iK6Bd4Q9U0NPiTtBelVIMUWVqFKtFJZe9zHjJGgY
         1u68pvzAlCzlNNRjwV+7TdQW58jLy3rg8z4Bqulf5CjyvEnRT0mJmVckNGZV1lTqw1+O
         Zy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QiECGMyoabW1BzY8/U8FfTuZG7oydQSw4kJVVQOhsls=;
        b=g0MbSiiyyHKI91pXlgIY8cLO3EX0MGwsU3gQnuk0bCZvJvqDdXGcNBqIAdFeOPANOS
         H1Ipo7wZrdc4DWOT89TnrsmzFXGKF32TE8f1mYTk7lAne4n9D8ZQO3Nb0vUXliFujkeC
         Bl1tzbXD8wozKFFRy740NuugaWfKTWlZmdEWdVD3ShLB2nc0JVe1FMucGdn7r359Gjq5
         VQWJhjpDIlcvg1ZreXDwjaItK6LSx/S1yChbsdYlR2Zs3Hdv5O9oCtOAS0/qt94T3CL3
         Taue6vnzByc68s3KtNwC+owa+8NP/5Kv2WxQKZ/0F+VOlGQgvEAH+rmrmfvsQ46H65RF
         b+8w==
X-Gm-Message-State: AJIora9hpg7EUWcoBhvQIT3VL7cbWUs/QWb1Y177FTDCrpnyqKLfr1wd
        +Malh6VmGVAAq2RcWmNOmnIYNXLp7iI=
X-Google-Smtp-Source: AGRyM1tM0+j8W13INQN3awI3s1/cI40DzRuDDIr8237DyTNdEskxBbWFDWtDO84wedjS48vwBijZvA==
X-Received: by 2002:adf:e186:0:b0:213:3b79:370d with SMTP id az6-20020adfe186000000b002133b79370dmr8983011wrb.151.1655465724721;
        Fri, 17 Jun 2022 04:35:24 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0039c5497deccsm17995819wmq.1.2022.06.17.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:35:23 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:35:20 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: rk3399-roc-pc does not boot
Message-ID: <Yqxm+IR9wApJCFMN@Red>
References: <YqxEL/pgv3zuH6aS@Red>
 <c12cc4bd-f7b8-5e52-14a2-41a0da83bb0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c12cc4bd-f7b8-5e52-14a2-41a0da83bb0c@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Jun 17, 2022 at 10:58:03AM +0100, Robin Murphy a écrit :
> On 2022-06-17 10:06, Corentin Labbe wrote:
> > Hello
> > 
> > I try to add rk3399-roc-pc to kernelCI but this board fail to ends its boot with any kernel I try.
> > It boot normally up to starting init but it stucks shorty after.
> > It fail on 5.10, 5.15, 5.17, 5.18 and linux-next.
> > When disabling CONFIG_USB, the board boots successfully.
> > 
> > In dmesg I see OF: graph: no port node found in /i2c@ff160000/usb-typec@22
> > According to Documentation/devicetree/bindings/usb/fcs,fusb302.txt, the port is mandatory.
> > Can it be possible that the problem was that the power port being disabled ?
> 
> Indeed, I believe the OF graph error is just a meaningless annoyance, 
> but the general problem sounds like it's probably the same thing that's 
> come up before:
> 
> https://lore.kernel.org/all/0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de/
> 
> Disabling CONFIG_TYPEC_FUSB302 or blacklisting the fusb302 module should 
> help confirm that. I have no idea if it's still an open problem, or if 
> it's been fixed and you might just need to define the proper power role 
> in the DT; this just triggered a memory of that older thread :)
> 

If I comment fusb0 node in arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi, the board boot well.

With the following patch, the boards boot well also:
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 0e45cc2d195b..60c400ca4034 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -552,6 +552,22 @@ fusb0: usb-typec@22 {
                pinctrl-0 = <&fusb0_int>;
                vbus-supply = <&vcc_vbus_typec0>;
                status = "okay";
+
+               connector {
+                       compatible = "usb-c-connector";
+                       data-role = "host";
+                       label = "USB-C";
+                       power-role = "dual";
+
+                       ports {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+
+                               port@0 {
+                                       reg = <0>;
+                               };
+                       };
+               };
        };
 
        mp8859: regulator@66 {

I think this patch is the proper way to fix, I will send it soon.
