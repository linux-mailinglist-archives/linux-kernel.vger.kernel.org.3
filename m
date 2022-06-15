Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4054C87D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbiFOM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbiFOM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:27:27 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF2200;
        Wed, 15 Jun 2022 05:27:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z11so8628916ilq.6;
        Wed, 15 Jun 2022 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5eqBdV0Z+YmLvaQSqb//FwnqjPlSldCQkZw39MaNsg=;
        b=WBQ3mVeIzMY0L1cC3DSnS9VWbvVSh7YZmPpQ0wwcvd+PqIWG+GLdIM4+sfOwlEhiLS
         ifLpTSNVXEwDcI/IGID6V/HBwWSro25/GYs6hLpwgifmTvgFS1HIZUs9STIf7g3/T3XZ
         W1+QPVvLLZ62HrVCzvG+GZoyea4z0AIxnsDNNFM/l9T3LsOquTUzKbg4MxIYaguZnF3p
         OVLBvWi4lf1gIf51+sgCYTwVtAnk6ctGKc622wyKJeMwpicNWbjYX3unx07KGMZkB25u
         4SW/gTbVJcb/4e5lKT0RW9eOK3MucrjqFMitp/w9DOkySvPG6g5V1cLLIVIu0K9xxVIK
         s9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5eqBdV0Z+YmLvaQSqb//FwnqjPlSldCQkZw39MaNsg=;
        b=6gDGbp4mJ9JTQ6GdgDCmIm4wACavj5XcixZVlNDkb9coQigtRDjOncAo/rqrMwLxkw
         kbFkEmK4FRmYOoNVJRXbnwLsZ6lxlyqMTCkiiyKL4j845aXWDvkZcQdweZhJtwAoQx/k
         ckLdGciZl9xFvHKIGjUPvyqFztTz3buAi0LHBdCEvgNBSBAnD5F05xMuXwAXcmK+IQq1
         GVycJ96x6RFDVYIXo1XvBCAnpIIqOgrO+i8+E2Pc3Z3ld3oha5dCrUJYiNrhieq2G+rp
         orvclo9GPPCaC0dnYctQtSmpx0P6J2FRom9r/CMOrAMEmKUW3SxWSCXDghzqDPZ1PsNg
         m/SQ==
X-Gm-Message-State: AJIora90cUVWtrhVXNi8pRCQfJf4cUdiCVm2w3WcBeMXsmkYmOOtpQwt
        3t3GjPqkU1LA8+LPxpeNORRFTsoMfz4k5MeNSzXqPDnw9u00iw==
X-Google-Smtp-Source: AGRyM1uFnJz7Rzs2KA9L2GhMGG+d3X/wPa8cy0NczGMixws8p3aVieOU+oEPSmQ+joq2houFVm1F3XOrdMN1IQM32sA=
X-Received: by 2002:a05:6e02:1a6b:b0:2d3:ae9f:112f with SMTP id
 w11-20020a056e021a6b00b002d3ae9f112fmr5732134ilv.187.1655296043891; Wed, 15
 Jun 2022 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220615104520.35687-1-eugene.shalygin@gmail.com> <4a6e1547-cdcb-81ae-79fd-b0e56fca2f76@roeck-us.net>
In-Reply-To: <4a6e1547-cdcb-81ae-79fd-b0e56fca2f76@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 15 Jun 2022 14:27:13 +0200
Message-ID: <CAB95QAQTJZbmJN_ey51LiEzo12L8Sbn3pBHE-zNarneT5S2GJw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add missing comma in board name list.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
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

> We have a Fixes: tag for such purposes. Please use it.
Thanks, done in v2.

Eugene
