Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F14ECA90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349255AbiC3R03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349192AbiC3R0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:26:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1AE6165
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:24:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id p15so42893698ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=52Imdz9LTLLhUAe2riVstsfW97W1L5sckaV7qKMt/gE=;
        b=l+fChiN/G7QlB0oP01+Qvg5n5Ivu04cIWjsZIJDHCAcAOowQHZBUfyXqWtNbKfoctd
         tI9MsRnfMsA5a/bt9kA8OweCNbYK9uCCoYB2iOo8oJUh/m0PBdtFz/OSSpwtM2GvX7hw
         ne6ogZkk4x02sOwgvRtmFej18zmBPs6dfmtrhrXn50wY8+juokugVQrFjcYX8N0R2cbs
         EKn8GJ07g34TG8wZMREN9U9vZ+DwcthhcAXZ1TqmbRCkLu9WuBcyMVgiKvxajaUkjfKU
         KQan/xSyrU4VCWGtwKEjD2fOb4KB6tr6YwZRX7Jp1F1vRShu+Xrkao87TnNL5XqkBjD7
         0hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=52Imdz9LTLLhUAe2riVstsfW97W1L5sckaV7qKMt/gE=;
        b=k8jNhH6f9fZtmSiO8OTWB/tcxOC585z7rb09nc+FVvybiZCIYFr9m6iRSJYFAtmhWb
         N4lYKxNG46tJruGlZT8mSlXPN5onnHgIbII1xW9h1RUk/0rjhobqPq0FH+B30sdeETZ3
         g5S+uaxZ1wD191sQqSAAITSuge5CbTiaXxrTHi80n4ImXxiBvLhTK3Bqs2qr4S40+DkN
         Fb+U+92bpx7AhHfcLGVZID8JMPxcZVz0TWEO0DZnVVltQu2bYZTGtrHa3WcmHPrCD7J3
         R6Os4r79P8pa3/Eu362fuwrphn5j/6KEm8+R6pX9XtOQSkE4D/BgJzEL76sBqRJNdGtU
         RKWg==
X-Gm-Message-State: AOAM5310gSRsJbFqgN9WT/4/nipLyq58ps7JX8JZUdz8czpGIggOI1NW
        2xdufA2vmiynnuWJkiXDZnG7aAzOxzEbjL9druo=
X-Google-Smtp-Source: ABdhPJzdotyfYEAOnFIQXJXfHJENMHvyzErr97xPrz2X3rh73YDVaJp31DFaANMjEXAYXXKM3nycU5bR0lgRC0OBSdY=
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id
 e20-20020a1709061e9400b006cc4382f12emr649377ejj.482.1648661073115; Wed, 30
 Mar 2022 10:24:33 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 18:24:26 +0100
Message-ID: <CAHpNFcPOyrPjxSVahyJr=ntrn-XGnzwc1K=aGWHX3pvePr-mCg@mail.gmail.com>
Subject: TOP BOOSTER Cloud Enemy(tm) Provided by potentially DLSS Cloud Founder
To:     submissions@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TOP BOOSTER Cloud Enemy(tm) Provided by potentially DLSS Cloud Founder :

We cannot all Buy a founders GPU But we can all use your Founders
Edition low price Cloud plugin for MMO & Online activated play Gaming
:
Cloud Enemy(tm) - TENSOR CORE + TOPS + We cannot all buy your cloud
GPU Founders edition...

for reasons that AMD & NVidia and ARM & Intel do not directly buy a
RTX3080TI Founders edition :p ^^ but we can all use your :

Cloud Enemy(tm):(c)RS TENSOR CORE : All GPU of note have TOPS and
obviously we all specialise <3

My proposal is simple : All special console MMO need a 370 Tensore
core server side :

Enemy, Friend,Pet, Emoti play(tm)

(read at the bottom of the post please, Bear in mind this does not
mean NVidia is the best at RayTracing..
But it does mean we can truly afford to activate the full benefits of
having ML TOPS..
Mobile phones often only have 4 TOPS or even 2! at the most 10 and
specialists like IPhone 20>30

But could all afford a small compliment to the Founders Cloud in that
ML is dealt with for the entire MMO by the cloud; That way no one
needs to know that ..

GPU RTP (Complex 3D RTP, Simple message, local cache, Monster cloud
render + local)(c)RSExists specifically for You the client:

NVidiaMicrosoft..
Google
Apple
AMD
Cloud gaming and service providers

Linux VM
Windows VM
Mac VM

Cloud Machine learning at GPU specialist clouds is of very high
potency & potential,
But for a 1$ a week subscription game like Quake? very hard at large cost!

(c)Rupert S https://science.n-helix.com

Cloud Enemy(tm)

Core strategic advice & adaptable SVM CPU <> GPU

SVM/Int List:
Hard mode: Smaller refinement
Advance Hard mode: Micro model save, Micro model regression

Advance BattleMode: Hard mode: Micro model save, Varied challenge
(small regression),Indirect reference chat
Advance BattleMode: Hard mode: Micro model save, Varied challenge
(small regression),Indirect reference chat,Personal chat
Advance BattleMode: Hard mode:RND resurgence, Micro model save, Varied
challenge (small regression),Indirect reference chat,Personal chat

(c)RS

Machine learning,
The Advanced SVM feature Set & Development

CPU lead Advanced SVM/ML potential
GPU refinement & memory Expansion/Expression/Development

SVM/ML Logic for:
Shaders,
Tessellation,
Compression,
PML Vector Ray-Tracing

Sharpening Image Enhancement:

(S=C2=B2ecRETA=C2=B2i)(tm)
Reactive Image Enhancement : ML VSR : Super Sampling Resolution
Enhancement with Tessellated Precision & Anti-Aliasing Ai (S=C2=B2ecRETA=C2=
=B2i)
+ (SSAA)
Color Dynamic Range Quantification, Mesh Tessellation, Smoothing & Interpol=
ation
Finally MIP-MAP optimised sampling with size/distance, dynamic cache
compression.

Machine learning,
The Advanced SVM feature Set & New developments..TPU <> GDev,AMD

Extended support for ML means dynamic INT4/8/16/Float types and dot
product instructions execution.
GPU/CPU/Feature-set/SVM

Dual compute unit exposure of additional mixed-precision dot-product
modes in the ALUs,
Primarily for accelerating machine learning inference,
A mixed-precision FMA dot2 will compute two half-precision
multiplications and then add the results to a single-precision
accumulator. For even greater throughput,

Some ALUs will support 8-bit integer dot4 operations and 4-bit dot8 operati=
ons,
All of which use 32-bit accumulators to avoid any overflows."

Core-ML runs on all 3 hardware parts: CPU, GPU, Neural Engine ASIC;SVM.
The developer doesn=E2=80=99t specify; The software middle-ware chooses whi=
ch
part to run ML models,

(c)RS

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?us=
p=3Dsharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.co=
m/

https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DAMD-PSP-Sysfs-Expos=
e

https://lkml.org/lkml/2022/3/30/1005
