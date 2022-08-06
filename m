Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441258B4EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiHFKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiHFKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:03:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54199DE99;
        Sat,  6 Aug 2022 03:03:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id y11so3348819qvn.3;
        Sat, 06 Aug 2022 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s4JW53l/rwhkjuydn9SbUuUWG8CvOPHHCEYhWqEX/qY=;
        b=q1jyGQhrdNvXXcxQ37Wj+Hrr+TAfhmLat5AbvoAZY/z2y5viHffc/PShAU0JVHKAt/
         +ssla/tfOq+5thaMbRP0VnqkFLbKQMBp8a3DgT8hk5HcwrL/qruLBVApTckrfe/ed/0e
         6Z6Ydksk7j9QDu37fMGPjJ83ZnDAF9N2sv1kYLzyjB2wQtEccpYd6TzWSsfPHQ+OKOCQ
         /CXhDZBboZdKKUKvqePcvezSkdWlIORaRthp5EgUuxOcmA1uImiASZxqwprZSeICNHmN
         hl0oyyMwDvsA+LUGpVdUKysdyCAHYiiTCspKbtMq9K+l0fdANK+R9U5QUFffUV3bKyBW
         FOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s4JW53l/rwhkjuydn9SbUuUWG8CvOPHHCEYhWqEX/qY=;
        b=RvX4A6wUBaaZ/2NmnRPRR0t33np+SubxivLdaVxs0esrxHOWVAeQj+c+XL07S5VzC9
         stmrn+w4Y7oIScU5RuDmGONlvm1GKjpgIjEFngE58aW2zceulnZdj3P3ccAF5HZEXUY7
         OwqjvmQEUrmL+Vq4YRIrkxtD3xL7XkM6tfq/QzVMtYFvvTjqJIdKuBxJYO27a7wwnI2E
         vWsPn6ModyQfTvwZcI92ggUdevpqz6uib/A55ZQulTPdC5yYN5FChp+a0awBBerU9qZQ
         xCsL8TtSiPmX7Y59F8yxLor1s23P5LuZJn9SOL2HyEDVLZDfdRmEt8C2vfDAfCGkusdm
         PsUg==
X-Gm-Message-State: ACgBeo2kuE8MQMBC3oRCViEwxMY0vJwambWso4vBqZ2/Cp73O0pVPh/e
        dR4QuT6qNKxUzkAOiwNc9gJJ0c78cJbi41/B0mc=
X-Google-Smtp-Source: AA6agR7B1cjwQ3mtyYX3ntrg5Ny7XS+MxZqE+SQ7y5Rj0/vQQzDmD3PnalTKvwWev4BXWXKkH4YvAGHEmpP25Fg9veM=
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id
 iu3-20020ad45cc3000000b004748ddadfb6mr8956650qvb.82.1659780179372; Sat, 06
 Aug 2022 03:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
 <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
In-Reply-To: <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:02:19 +0200
Message-ID: <CAHp75VcrSe4aTYo_cVCfhX=y1LjZPOJG1yh9SrLt_XQBzNoGhA@mail.gmail.com>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Aug 6, 2022 at 11:33 AM Luke Jones <luke@ljones.dev> wrote:
> On Sat, Aug 6 2022 at 11:10:37 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> I do have another version already prepped

Hold on and try to address many more review comments. It seems the
series needs much more work, otherwise it will be spam in the mailing
list and demotivating reviewers to continue.

-- 
With Best Regards,
Andy Shevchenko
