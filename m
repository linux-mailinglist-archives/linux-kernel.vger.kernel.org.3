Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BB534BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbiEZIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiEZIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:46:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C13E5FD;
        Thu, 26 May 2022 01:46:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o80so1873873ybg.1;
        Thu, 26 May 2022 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MnY+75yaFpPmjAWFmxJr1ChfpUtDSQjtIKbQOgLely0=;
        b=oPJtsyrFZIJkwUmv9Ks8yXpKKCjURNdJRmoGKf0dndmyo8zKnB6aD3XRr7TIU0qRvK
         kyAOfqvxMeZK4y/qlBhO/bEmSRJz3YntcOY//uxIPXpk4bG/8y9zWY5tCpD5GjBcYZvX
         XOC5XOfa5vKfzDPUpzU4up4Iciv1wNcXh8VuUWEG+QJvWiLGFnOYXrA0yeDCUZEsc2MT
         XNFjseh0vNq0q9at/+LMnMdy2T01YBJXjrp2etXQVhPCZFIMQPICQW8EOlyyi1ppCKZT
         6b1Kv7jLTKN0amLWOu5Dy0EElAoklXMh3l0vAVypdGcIblXY3CSpgqLnlPA9MN6DR1FL
         Dpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MnY+75yaFpPmjAWFmxJr1ChfpUtDSQjtIKbQOgLely0=;
        b=fUi2DuKZMLM+NVRiAIjGGvawcUWIGPAZlJIm6Lnq4bWoYF1kFNEQMmK8TchOuUqala
         y1m1ULFAwJNKIY4RGwObgpB8kalYVz1szBcKL3MpTBkXk5jAD2vBrWXy8q9vgKT66n6L
         8bK05nhy6Rdkqo0w3ACi8czO1jC7aOQerBLcxHzATDNRii3Ge8XUuQvpxXFahd07CCbU
         7u/zokoJynIeXywH4mToYnxQCtmpy6szh4RSLPY8trz1JSbmy18NnZbQUQh1kZDMDQMu
         R6ufRC8zfC4QgugtU8TJfAX4AvIZ1p0e/Fz5HDR7rNON7sd2Qqv4W72iQrJLHW+4iAu+
         rlow==
X-Gm-Message-State: AOAM530M2+wxFHE3QPVMLg/aWEAN67LPHebVEJv2YiHoAj92q1sRsiH7
        fy7gAXVymxsETgBd+nYQS3JG07bmu6VKTjoIzYgbTM4z
X-Google-Smtp-Source: ABdhPJxZFU4h9YxHSV5CxUe4ezrjnStAZaiSnUpTNUOJY0kbfjv6ia1TCXsKO/lAjA5di75hkY9csSTNGQvZtcxwFVo=
X-Received: by 2002:a25:9901:0:b0:651:e25e:febe with SMTP id
 z1-20020a259901000000b00651e25efebemr11176373ybn.58.1653554792099; Thu, 26
 May 2022 01:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjGWp4+Ub_Ccaw+tx1NQrNcqyjUG5K30uPH3uYTF_wxfw@mail.gmail.com>
In-Reply-To: <CAOuPNLjGWp4+Ub_Ccaw+tx1NQrNcqyjUG5K30uPH3uYTF_wxfw@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 26 May 2022 14:16:20 +0530
Message-ID: <CAOuPNLgzBA2Sbn6vS4856LwYyBo67OYKQp49+xpwX=Bi+KpLZg@mail.gmail.com>
Subject: Queries: Using ifdef CONFIG condition in dts files
To:     open list <linux-kernel@vger.kernel.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a generic question regarding conditional compilation options in
dts/dtsi files.
Our Kernel version is: 4.14
Let's say I have a Kernel config such as CONFIG_XYZ.
This driver uses a CMA reserved memory and its node is defined in a
mysoc.dtsi file.
Like:
#if defined(CONFIG_XYZ)
&reserved_mem {
        xyz_region: xyz_region {
                compatible = "shared-dma-pool";
                reusable;
                size = <0x600000>;
        };
};
#endif

The problem is as follows:
a) The same kernel/dts source is shared across 2 product versions.
b) In one product we need to enable this CONFIG_XYZ but in another
product we need to disable it.
c) When we disable the CONFIG we wanted this dts node also to be
disabled together.
d) When we add "#if defined(CONFIG_XYZ)" check in the dtsi file, it
works if the CONFIG is disabled, but it does not work if CONFIG is
enabled (node is not getting created).
e) This mysoc.dtsi file is getting included in many other dts files,
so we cannot add a compilation check in Makefile. We will end up
renaming many files just to protect this one change.

Is there any other better way to handle this situation ?

I see that in latest kernel we have a conditional compilation added like this:
#ifdef SOC_HAS_USB2_CH2
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/renesas/salvator-common.dtsi#L1028

But the same is not recognized by the device tree compiler when using
kernel CONFIG_ check.

Is it the device-tree compiler issue which got fixed in the latest version ?
Or, is it because Kernel config cannot be shared with device-tree ?

Please let us know if there is any other opinion.


Thank you.

Regards,
Pintu
