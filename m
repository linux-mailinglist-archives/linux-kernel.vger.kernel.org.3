Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893505306B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 01:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiEVXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiEVXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 19:21:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C120F42
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 16:21:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so6143722otu.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kjbY7GOcuLABhyDVSO3ZAtEU7xGuENV8mMhgvqeQ5s=;
        b=RJ9DFp+FdezTGINsUL4tc03uCgSWVjYq3Tp3wakgvd/EnlNnMtn93gXFBiZtL4MyyY
         mjSeb2bOvstG6r3zzY+TEod9FDak4nFHQTSqKrVepEDL6/HoIELXoQqd8m2oZ/QoYOTK
         kA5gB+/5FAwDG/zs+Os6VFtf/6qhh89CFSiT/VG8kgbGNG5PRUFS2VNifNSpV23nYezB
         9kJeSHpaX82JWLRi3So47FtTV73osLBtK/IE/4FGhzxwAmJcsavmSwHWoQbldRDHCN6x
         0Ny+ZxIBah9WYtozAF6BV8Yi/FrkQtlJr/fSNpEMMvsvxUdREzDrYdWBXNkrQWJ26bDN
         Bujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1kjbY7GOcuLABhyDVSO3ZAtEU7xGuENV8mMhgvqeQ5s=;
        b=gKl4CVGtBSZG3wXEzpGoF3p6LKRo5GGFR+gf0sS1YGrR+T8hbEhji2YvODLTVYp2We
         VOL5l1/0pzyAB6yx0+iUyJU9qJzAON5TGVUck1/mr9stQlU08y6TIkxaBXJbx0MlvF5k
         aT6LK1Uu59snj0/Xf2j7mUMfe8mCJMltnyouWQCmzrYawsNyrUXfkl1BfmYPJpeHf0p7
         eRyGp3/jYVFAuNyJPzZ/Xtaw1wH2yvP2xxBHVpMEM/zO23i+K4dBd4fAD+mfNVbbI1aA
         Ow3MrtsCtZfZjsd+QQ2Dh0EvQUCgp7stoL1hU63AnufcZsLctkKyXkIXhIlLeEDAVTx3
         dA+w==
X-Gm-Message-State: AOAM532k04kghT7/kieK/6vYp1CIRx7RTTb4ipgV+VlurPGOUdSAgEH3
        6q8GrlUMC9q8TWq6UP6Zs7SyaUwGXtSeWQ==
X-Google-Smtp-Source: ABdhPJzK5bp3cv42EDldBwKOgZPSUE7UNweReFKSn8zbi4Mcx71ndrW9vdvVaH13LejH4CWA+VvRiA==
X-Received: by 2002:a05:6830:2b07:b0:60b:b38:fcc0 with SMTP id l7-20020a0568302b0700b0060b0b38fcc0mr1922059otv.353.1653261714991;
        Sun, 22 May 2022 16:21:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a056871060200b000f26bfe3d56sm499176oan.34.2022.05.22.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 16:21:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 22 May 2022 16:21:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18
Message-ID: <20220522232152.GA3768949@roeck-us.net>
References: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjiqyoH6qntYvYTjR1F2L-pHtgX9esZMRS13iktCOJ1zA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 10:02:09AM -1000, Linus Torvalds wrote:
> No unexpected nasty surprises this last week, so here we go with the
> 5.18 release right on schedule.
> 
> That obviously means that the merge window for 5.19 will open
> tomorrow, and I already have a few pull requests pending. Thank you
> everybody. I'd still like people to run boring old plain 5.18 just to
> check, before we start with the excitement of all the new features for
> the merge window.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

Guenter
