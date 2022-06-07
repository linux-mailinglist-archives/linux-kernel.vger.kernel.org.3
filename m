Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF845426BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiFHCOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390063AbiFHBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 21:06:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D914AC98;
        Tue,  7 Jun 2022 14:16:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so15909274plh.1;
        Tue, 07 Jun 2022 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4ynvHOuA0UQNC2oRu92nWz6l84967KcpkXtkWQovvGY=;
        b=mTIl9CfWrG+VkaAtrQuOjn2IDncZ/sAU+K6Sv0WHMpCrbrYuncJcRW5kG7Q9uhy2ak
         Plj5CfsWLG8GtAEv/XmPHw1NJUt/xzg5SaM7RKSCTWvc+1Crks/VDgv8z5dwSyXZ3qGd
         jXRPIjjth0TPhlImr12DV4mUzetCL1Q1tOU54OQa/hACA9RWdZje4LiD9O+CLYK98li+
         g3XtL8TAET8eLeSSn9o9AMBa9x/y3ybbx7fwY6zRce/7dytYPUa5VRU4PyxG5WCWFvEw
         VsHPwTJshGJhU1wB1NCM3FJN9jiL233OXzoYAhRyvImWN5XHtZQMOCSf+UGf92TpoFtg
         qjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4ynvHOuA0UQNC2oRu92nWz6l84967KcpkXtkWQovvGY=;
        b=C/Z9Ixat/y+Ip1BpklCwYJSDy7COdXNJiUcVMpzsj/Gq4DQRAVdDlVdE5MXHR9zOh2
         i+k+SfYrdp5sWEjN/04oDRLxAWENgmEYfNObisBYc0CJ4Xh/FX7YdmPVeJ1mz0yE4N2D
         NUsvfUrKuSpeszIsb0dJ7UoDgr88vOOWRhLN3UzU63aO8kMvf6Tlr3IOJj+kDLwIMH3n
         /6b1U1FJRZ+oFur4mzpPh3MYr/Rqkqid5XtTR6Ns7ScY7vVb5SzPzlK2pXX7Y+EKsI4w
         3bbkajV0kUUo4yAffjN1eLT9xq4V0aoG+du3RpRrIOkXG4ea+gi7GK0VB7OJkNCCvec/
         7eiA==
X-Gm-Message-State: AOAM533zHwaLZ9KBJo9VTRn6h8hfvENPx3J1IKD1fECPbgXxcQ66oLlH
        63DTPzHbDIR+XpG6J2wLmPM=
X-Google-Smtp-Source: ABdhPJwmjbCHibWwnEg/qIGFL8LWHE1mijj1VoqSthY2/03Kk5agVP1W9zKbb4ON/+xsIQKayZGAmA==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr30960450plh.162.1654636571800;
        Tue, 07 Jun 2022 14:16:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1ce8:21b3:ff45:f42c])
        by smtp.gmail.com with ESMTPSA id cp14-20020a170902e78e00b00165103c9903sm12904952plb.113.2022.06.07.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:16:10 -0700 (PDT)
Date:   Tue, 7 Jun 2022 14:16:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.19-rc1
Message-ID: <Yp/AGMpXXnx9lW6j@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc1

to receive updates for the input subsystem. You will get:

- proper annotation of USB buffers in bcm5974 touchpad dirver

- a quirk in SOC button driver to handle Lenovo Yoga Tablet2 1051F

- a fix for missing dependency in raspberrypi-ts driver to avoid
  compile breakages with random configs.

Changelog:
---------

Marius Hoch (1):
      Input: soc_button_array - also add Lenovo Yoga Tablet2 1051F to dmi_use_low_level_irq

Mathias Nyman (1):
      Input: bcm5974 - set missing URB_NO_TRANSFER_DMA_MAP urb flag

Randy Dunlap (1):
      Input: raspberrypi-ts - add missing HAS_IOMEM dependency

Diffstat:
--------

 drivers/input/joystick/Kconfig        | 1 +
 drivers/input/misc/soc_button_array.c | 4 ++--
 drivers/input/mouse/bcm5974.c         | 7 ++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

Thanks.


-- 
Dmitry
