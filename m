Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A75AC0CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiICShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiICShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:37:53 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF75508D;
        Sat,  3 Sep 2022 11:37:52 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g5so7475453ybg.11;
        Sat, 03 Sep 2022 11:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=acDSEwPpSGt3/Sa5qq4bY+mv4UxFi1+u/sdIo3dqsdA=;
        b=eYIwM776Zt85HLgKO1nltSzhkzgtmZX/jfz3y92HAl5ZhzJGkEweHuG7xUVmNK6Ezk
         uUxyIofTcuK7fWCuOTQcmyJVRQ/s3wxZPFcep9MpT7q+At88+ft6gIY0EqOa50H3TZyS
         gr//rbWcywXXl0NYHr3SpWSFTaNi03p3C2WMiC4DjbD5nnCH2tST+W8WhGj2DxaUtaUZ
         XG6hoGDD3smPUIV2D9NGkyzsUtBu0JizrDCt7lCfQpG40Yb/vap0D8FCOnq5/9EnBqFU
         L3eEdvRNI1T5yigfE5AVB0sZq1p5R9vw57GXEmTk/BhwwpT2dDFofIQX0HiEsxFBCsLJ
         i/vQ==
X-Gm-Message-State: ACgBeo2O7GO9ZltxqiSbtj4CqRQs59COvu0pZ70N2+kywq4OlPJCuGjQ
        HQHKM9Z1fbFN6Tgt5YSzyGsUt3aYaSvm8q3MyyA=
X-Google-Smtp-Source: AA6agR6IMJjLlJF0+Lly/WQ6I0yuPNaw47XRD0jcLbl2HZeCIJDsqPDyndKaaTGcHOy837NXuZypEIr2aC/54bb8d5s=
X-Received: by 2002:a25:2785:0:b0:69b:b1d2:fd05 with SMTP id
 n127-20020a252785000000b0069bb1d2fd05mr23015642ybn.81.1662230271421; Sat, 03
 Sep 2022 11:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jVpCiwscgVQqS3yEwGaHUCPzR9pNDjt6qY6U4jJubt_A@mail.gmail.com>
 <20220829030555.22418-1-junming@nfschina.com>
In-Reply-To: <20220829030555.22418-1-junming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:37:40 +0200
Message-ID: <CAJZ5v0g9L61BXztCVFreEE3W9skzR2LGukhwjEzDbbr8F6PaRw@mail.gmail.com>
Subject: Re: [PATCH] tools: Delete the initialization value
To:     shijm <junming@nfschina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 5:06 AM shijm <junming@nfschina.com> wrote:
>
> yes,just your said!

OK

I've applied the patch as 6.1 material under a new subject and with a
new changelog.

Thanks!
