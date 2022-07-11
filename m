Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA7570812
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiGKQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGKQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:13:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE927A50F;
        Mon, 11 Jul 2022 09:13:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v21so2321492plo.0;
        Mon, 11 Jul 2022 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=1BtirUFZlUNsNaJ0rGa4j2n8R2Nb+qFWRgftNDn7dlM=;
        b=h2gP/eINh3df/khVpYyOKAFueaRwnze8whTPM4NWnJhXedhNVdiYw7q36eqbuk2+b2
         x9yIbcmMZ07Xc7n7eTivCKkImfW2gbCrlNL7Va25RMwU9StsglbqTN88W1rLDjwueG2U
         MA8Agg8kStw9PZ+SHWNSZHh5bL+8vfgdcGvT+aszFKSptbnsV42YwLIvz2NmhlfT6KWP
         0psdwRlghGHK0zrh7XZehpiSD3xdWr7xD56y07PrqCexG4YVWeznvWxWcy6LHvIc8B/l
         7kcJlwCMs9z53KdaK9c8p3mQ7Vrimb+0YNsRHZlO1N+d/Xv2hdgezVoi22iNgkExNUCr
         poqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=1BtirUFZlUNsNaJ0rGa4j2n8R2Nb+qFWRgftNDn7dlM=;
        b=jJsmT/lqqHKfMe4j5FMz0qjOYmEnsiJA9yRc+EunXLnfEkoPcInborXMcFOzTAvxIY
         QT2n6g2JVDJ/oRNexzYDH8AAqxNHnlZOn4Lpx5f0yIR9aHMSEsKjhKPxOISjcovSa1Bv
         /BrPCONOIH+bSvwd6eP3JjwmmJVavwQiKv4gNWzGyMv5pW4SMJYXHIqUV+92q3AZjtpY
         x1oPCs43ZuvDFcq7Yb7z3a4p0aYNE4KJiGlSTyV9qAKsbgJjZy7wdbgO+udkO8DSz+cb
         PiD5OoCB9QuJz8gA/Cyj8cVtE6qHxuQWlzB8XwcNRA5CIeKcstPZdoFbfDK6LhnZy3sa
         ZmtA==
X-Gm-Message-State: AJIora++j08gyPt4itBy2O9UeS65tW/mLBzmjimK4B8hUIadC8nWorKu
        ol8VQYQeYKCa23QX/+yRclY=
X-Google-Smtp-Source: AGRyM1uGPEntwk/brrDrAanebOrOr3Lt4WdZYw78TD8cNiNnyXHKbxBrBweYKn9sc24tLdRLZ3CAOQ==
X-Received: by 2002:a17:903:2452:b0:16c:18f4:7997 with SMTP id l18-20020a170903245200b0016c18f47997mr19363436pls.68.1657556003779;
        Mon, 11 Jul 2022 09:13:23 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b0016bdf0032b9sm4932804plf.110.2022.07.11.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 09:13:22 -0700 (PDT)
References: <20220321053815.71316-1-schspa@gmail.com>
 <YjhF/jWXY5L3I+DZ@linutronix.de>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 5.10-rt] printk: fix suppressed message print when
 reboot/panic
Date:   Tue, 12 Jul 2022 00:05:51 +0800
In-reply-to: <YjhF/jWXY5L3I+DZ@linutronix.de>
Message-ID: <m2r12rocfd.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys:

   Do we need to add this to the rt stable tree?
   The stable tree still have this issues.

-- 
BRs
Schspa Shi
