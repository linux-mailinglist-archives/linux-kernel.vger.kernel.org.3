Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9D554653
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbiFVKmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiFVKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:42:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ABF3BA5B;
        Wed, 22 Jun 2022 03:42:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t5so778437eje.1;
        Wed, 22 Jun 2022 03:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37Up7Q+E7aNLIzK+/9P291s/Evoa8vO3ddA5Mh3BGI4=;
        b=UPpZ3epkUHLay8Yvl5td6j/JJk7qr1KDfQy7FRpHjs/Xt7jbwOpfS4sZ6XZtoNKpsZ
         amUaBaebChLzx3T/6M6rqqqQbDb48xG+TkFLsFGSFkfRW0RF3In24nynEHHpwIqMXP9c
         8PpVFtWdm5THRY1j6B84xDavv4TWH1Y8CXPJPp6xK2EFmbSNTEJ5NRlppVK1tKFvQe/w
         Eyebr00L00dbq+faCf/oZbK88iRJHCJE2IRBKIIYFtBNrc6bJJBI9MiJ5f8YcSl3s83X
         x60Dt/59VCgGGf+vc1j8fvJgxfo7Zj/GNFXuWFYtx9SfUNYNs3fgwOkoIGN97S76iDGz
         is+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37Up7Q+E7aNLIzK+/9P291s/Evoa8vO3ddA5Mh3BGI4=;
        b=jfpCI90M3fHnOCqFLM1s/y96BNbR14Ikb+LWTRn47ALpQTXWQ9tKmyZlhffdEZ+G/8
         Ww5b9ZTO/DdRw/WRcbpTUC3w7EteJFhYkSKwMIJIdXLTvetOlQY/lgN/Xe7QE3xg/GEU
         5vjCbuTTXwmiYXJnRNVoGot1UpzUo8HSwBSqo32QD4NxigwczpZjLt/Rju7V2NA0TOHl
         b0qxT3tFwtNvNUnpHFDGDUpJF8zq/tD5RoU2z9zWqBlSaXmtP33tuPBuP5LlagJhAth3
         smjWMF1pswoFghLbUZh3aLnYs8xRAOlWgPhkJ7FjQkkTnmaMIp3mvq1KBCCzCSOUOrBO
         ZdhQ==
X-Gm-Message-State: AJIora8l7W1k3iGqrU8tfO8RfifraIv5PlFubKbqKiRO/60xt5XR0usW
        gM7aJPbFbP+yOkHxMvbvFUBNph5/sjoG7Ox4mElt/2ZKKGAJM4wS
X-Google-Smtp-Source: AGRyM1sfTD6x0jVMEZdlRKBZJngZaj4PMmitb1m4ZA9nk6du/4cNgPwReAEfshaAJPt6v2IW+965A5+pRUEMoyzudYg=
X-Received: by 2002:a17:907:2d09:b0:722:f0bf:ac26 with SMTP id
 gs9-20020a1709072d0900b00722f0bfac26mr2462307ejc.77.1655894555106; Wed, 22
 Jun 2022 03:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220621150436.3303431-1-sudeep.holla@arm.com>
In-Reply-To: <20220621150436.3303431-1-sudeep.holla@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jun 2022 12:41:58 +0200
Message-ID: <CAHp75VfX7ZbK67WhRjuw-s0VF5QZk+dvYEYrN+Kw1ucXofN=yg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Update links and references to DSD
 related docs
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
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

On Tue, Jun 21, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The existing references to DSD are stale and outdated. The new process
> and guidance is maintained @https://github.com/UEFI/DSD-Guide
>
> Update the existing documents to reflect the same.

Hmm... On one hand I like the change, on the other the mentioned
repository doesn't look like it is officially supported by ASWG (or
did I misread something?). If I'm not mistaken, then I would rather
see both mentioned. Otherwise it looks good, thanks!

-- 
With Best Regards,
Andy Shevchenko
