Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A3533E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbiEYNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiEYNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:50:16 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA03584D;
        Wed, 25 May 2022 06:50:15 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-300628e76f3so8260657b3.12;
        Wed, 25 May 2022 06:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7pNBXTzwb2NC+1B3pkw6XahPKXPrihCDQqGfh0Wnzo=;
        b=UDr7JM9Zp9EaPbB6flSIhtvB2rBN91LXcTY6rg/XNnEmkypBFmx8VaTIPQWW7V8ljq
         wo0gjJ8H82RLcuAuAp61ucpo/HIOlDaFBawgJ97i/2HsqrfRjL9czqv5LJDN0NmSwaQM
         Fzz7epy4GXkt3VAR36Jb+cAbHG4vkJDiUjSnw588eCXVvbFMo43fkZd7K97uY5S3VU7T
         bCUNYDZbsjmD5a49QjGwRayassCze0fNleUcVCuSgR1vNt5cNbGeA19EQoXkjCYqUFzw
         vZLKNq5tnPuEX03Mijp75rOZ+5QG3KPuKjO2QLLbfG4l7Xq3EtFGNyVKRR9xkwXaDZ56
         AHAg==
X-Gm-Message-State: AOAM532xuiA1s+IhedFnUiIIb/k6AvbWzyRRzdLLPJxt5JqOpzPELD/D
        awreOjGkSXDody8TroDrslNsU1tLqzuAXdBwspkY56N+
X-Google-Smtp-Source: ABdhPJweqWSCLXeXw+r+GeogMl1WGgJ5ajSlE51Ud/iUBvqvwf0bA2VMSP4GcN/QX3cCdkBu3ImXYBXI9ubr+DisxJk=
X-Received: by 2002:a81:87c4:0:b0:2ff:c5dc:72b9 with SMTP id
 x187-20020a8187c4000000b002ffc5dc72b9mr19519391ywf.19.1653486614968; Wed, 25
 May 2022 06:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220523181655.2352470-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220523181655.2352470-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:50:04 +0200
Message-ID: <CAJZ5v0je=rTPG+y-CSd=mi4RTbOq2zni7-1SdKmbNadhUUihCA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: admin-guide: pm: Add Out of Band mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 8:17 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Update documentation for using the tool to support performance level
> change via OOB (Out of Band) interface.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> As suggested by Jonathan
> - Indent literal block
> - Show output of command
>
>  .../admin-guide/pm/intel-speed-select.rst     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
> index 0a1fbdb54bfe..a2bfb971654f 100644
> --- a/Documentation/admin-guide/pm/intel-speed-select.rst
> +++ b/Documentation/admin-guide/pm/intel-speed-select.rst
> @@ -262,6 +262,28 @@ Which shows that the base frequency now increased from 2600 MHz at performance
>  level 0 to 2800 MHz at performance level 4. As a result, any workload, which can
>  use fewer CPUs, can see a boost of 200 MHz compared to performance level 0.
>
> +Changing performance level via BMC Interface
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It is possible to change SST-PP level using out of band (OOB) agent (Via some
> +remote management console, through BMC "Baseboard Management Controller"
> +interface). This mode is supported from the Sapphire Rapids processor
> +generation. The kernel and tool change to support this mode is added to Linux
> +kernel version 5.18. To enable this feature, kernel config
> +"CONFIG_INTEL_HFI_THERMAL" is required. The minimum version of the tool
> +is "v1.12" to support this feature, which is part of Linux kernel version 5.18.
> +
> +To support such configuration, this tool can be used as a daemon. Add
> +a command line option --oob::
> +
> + # intel-speed-select --oob
> + Intel(R) Speed Select Technology
> + Executing on CPU model:143[0x8f]
> + OOB mode is enabled and will run as daemon
> +
> +In this mode the tool will online/offline CPUs based on the new performance
> +level.
> +
>  Check presence of other Intel(R) SST features
>  ---------------------------------------------
>
> --

Applied as 5.19-rc material, thanks!
