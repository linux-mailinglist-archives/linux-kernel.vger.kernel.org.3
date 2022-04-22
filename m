Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D822450B09D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444390AbiDVGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444354AbiDVGa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:30:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F750B1A;
        Thu, 21 Apr 2022 23:27:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so8732649pll.7;
        Thu, 21 Apr 2022 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ANMx7UH+NPfrCbf5cBhjV/dhC+h0aHFxPNEZIAsabjU=;
        b=k5jhh7JuRVyX9TWrpxlSEbEX0Nt171tL79woBXkQhSEowN/D5gl3ReKtH5hmggd+MK
         A5YYH1IFGTWHZT5qocCGTFO6Hs3IaMYrJEbRQw9xo/qpzIspmZtbKYfLXkNgDV801L/j
         Tms9s0xRKbQJPkwz8QOlJEJXqN/3cl7IyJIpjEGIgYVDrwZrttXrvPKse+0mQN40gDPM
         CI670odqJAdu0tIY3ph6lF6nveSmvj5FI8TzhwXsT5lNCygkJqwCE7JhcHhHM/X5MoLP
         1KBR74mVof1wQs2cXNf6Q/jaaQ7aFQq1RamEDKZAFasSHv/YwA1rbVcCRx/ocaq1ZlYd
         KKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ANMx7UH+NPfrCbf5cBhjV/dhC+h0aHFxPNEZIAsabjU=;
        b=kUVmYHyiQMeeGTEmhrPpDC18OAt8jiE+If955fkcozst+d91op1+mOVQlkpA1JmOcP
         WKHrjuHRsuJOs6Qno3RseLrUbX1bD7v94X2M/p7nBPult3Qa5T6r9rHHy60LjRtzU0lT
         KR/BxaaXlxqMwAHi8r3tnfb2GgJqswxXuB0Sp/8rYNOoBZZUHT4O4TlV3c0Fzgv7c3a5
         r4vILnwVVjRJr5qPRvQOl2ndhqTGmmCT4djZIUHrD9/sT+Z1qg1OPseMpIvTdtCNL1xi
         eeXLFf52nWtC+qQsrmo8/bcBSiRnYB18NhjsUYF7bWcFXVt7s/tq9qA5SuKfAub0K+Xw
         Y3Yw==
X-Gm-Message-State: AOAM530BY2TaUSnoS/WFrFBPWI8nfMsRrH0yxkNPfj/BbScSB92/sI+p
        n9k54LDd41FSx7H/qbpd0k8=
X-Google-Smtp-Source: ABdhPJw5TsqA0mzOzghri1mOJpJnumOn+l0EIBtdBgOzXtpDip5iImbMUpnV0AYWewMwJnUqZZtRfg==
X-Received: by 2002:a17:90b:3ec8:b0:1d3:e8cd:e8f9 with SMTP id rm8-20020a17090b3ec800b001d3e8cde8f9mr3647578pjb.156.1650608852598;
        Thu, 21 Apr 2022 23:27:32 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a600500b001cd4989ff62sm4808707pji.41.2022.04.21.23.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 23:27:32 -0700 (PDT)
Message-ID: <07155685-3adf-09c8-9a13-6c8249d5fd74@gmail.com>
Date:   Fri, 22 Apr 2022 13:27:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 4/9] docs: misc-devices: (smpro-errmon) Add
 documentation
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20220422024653.2199489-1-quan@os.amperecomputing.com>
 <20220422024653.2199489-5-quan@os.amperecomputing.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220422024653.2199489-5-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 09:46, Quan Nguyen wrote:
> Adds documentation for Ampere(R)'s Altra(R) SMpro errmon driver.
> 

Hi Quan,

Building htmldocs, I got this new warning:

/home/bagas/repo/linux-stable/Documentation/misc-devices/smpro-errmon.rst:128: WARNING: Malformed table.
Column span alignment problem in table line 56.

============   ==========    =========   ===============  ================
Error Group    Error Type    Sub type    Sub component    Instance
CPM            0             0           Snoop-Logic      CPM #
CPM            0             2           Armv8 Core 1     CPM #
MCU            1             1           ERR1             MCU # | SLOT << 11
MCU            1             2           ERR2             MCU # | SLOT << 11
MCU            1             3           ERR3             MCU #
MCU            1             4           ERR4             MCU #
MCU            1             5           ERR5             MCU #
MCU            1             6           ERR6             MCU #
MCU            1             7           Link Error       MCU #
Mesh           2             0           Cross Point      X | (Y << 5) | NS <<11
Mesh           2             1           Home Node(IO)    X | (Y << 5) | NS <<11
Mesh           2             2           Home Node(Mem)   X | (Y << 5) | NS <<11 | device<<12
Mesh           2             4           CCIX Node        X | (Y << 5) | NS <<11
2P Link        3             0           N/A              Altra 2P Link #
GIC            5             0           ERR0             0
GIC            5             1           ERR1             0
GIC            5             2           ERR2             0
GIC            5             3           ERR3             0
GIC            5             4           ERR4             0
GIC            5             5           ERR5             0
GIC            5             6           ERR6             0
GIC            5             7           ERR7             0
GIC            5             8           ERR8             0
GIC            5             9           ERR9             0
GIC            5             10          ERR10            0
GIC            5             11          ERR11            0
GIC            5             12          ERR12            0
GIC            5             13-21       ERR13            RC# + 1
SMMU           6             TCU         100              RC #
SMMU           6             TBU0        0                RC #
SMMU           6             TBU1        1                RC #
SMMU           6             TBU2        2                RC #
SMMU           6             TBU3        3                RC #
SMMU           6             TBU4        4                RC #
SMMU           6             TBU5        5                RC #
SMMU           6             TBU6        6                RC #
SMMU           6             TBU7        7                RC #
SMMU           6             TBU8        8                RC #
SMMU           6             TBU9        9                RC #
PCIe AER       7             Root        0                RC #
PCIe AER       7             Device      1                RC #
PCIe RC        8             RCA HB      0                RC #
PCIe RC        8             RCB HB      1                RC #
PCIe RC        8             RASDP       8                RC #
OCM            9             ERR0        0                0
OCM            9             ERR1        1                0
OCM            9             ERR2        2                0
SMpro          10            ERR0        0                0
SMpro          10            ERR1        1                0
SMpro          10            MPA_ERR     2                0
PMpro          11            ERR0        0                0
PMpro          11            ERR1        1                0
PMpro          11            MPA_ERR     2                0
=============  ==========    =========   ===============  ================

I have applied the following fixup:

From f16c63afa2064247507762ffcb623f575043f4a6 Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Fri, 22 Apr 2022 13:16:31 +0700
Subject: [PATCH] fixup for "docs: misc-devices: (smpro-errmon) Add
 documentation"

Fix table syntax warning

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/smpro-errmon.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/misc-devices/smpro-errmon.rst b/Documentation/misc-devices/smpro-errmon.rst
index 53599904da7008..818f12bd8aca4d 100644
--- a/Documentation/misc-devices/smpro-errmon.rst
+++ b/Documentation/misc-devices/smpro-errmon.rst
@@ -70,8 +70,9 @@ The format of the error lines is defended on the alert/event type.
 
 Below table defines the value of Error types, Sub Types, Sub component and instance:
 
-    ============   ==========    =========   ===============  ================
+    ============   ==========    =========   ===============  ====================================
     Error Group    Error Type    Sub type    Sub component    Instance
+    ============   ==========    =========   ===============  ====================================
     CPM            0             0           Snoop-Logic      CPM #
     CPM            0             2           Armv8 Core 1     CPM #
     MCU            1             1           ERR1             MCU # | SLOT << 11
@@ -125,7 +126,7 @@ Below table defines the value of Error types, Sub Types, Sub component and insta
     PMpro          11            ERR0        0                0
     PMpro          11            ERR1        1                0
     PMpro          11            MPA_ERR     2                0
-    =============  ==========    =========   ===============  ================
+    ============   ==========    =========   ===============  ====================================
 
 
 2) Type 2 for the Internal SMpro/PMpro alert types::
-- 
An old man doll... just what I always wanted! - Clara

For consistency with the fixup, you need to format the tables so that
headings will be emphasized, by adding second ='s line before first
content row.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
