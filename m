Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81858CBF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiHHQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbiHHQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:15:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116FD559D;
        Mon,  8 Aug 2022 09:15:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l22so11462752wrz.7;
        Mon, 08 Aug 2022 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=J9w4Uw+mJQZ0qiMoimYZNyfJ80DjkGzw/tF6TsleD38=;
        b=OT7Uo1A6oiFck/ynH1HvY1JnqyhE9tBYd0Qw1Ojxs1lmeSOPkMQsgE47LUbf7NnHuP
         jR9nyxYX/xBu0IRVTKQikGIskHX91qgppvsvIxBFH0id2sL9oZ7BzQgp+/g1u6hM6jCl
         xV7Xv3HgzWF366B729OMMNH9N3UaMy5bqVAF42TUGR2AIRDkHF7dIamfm2LphNisQsX4
         zW7cv55+5wsovBUFND2eOY6mQISVC9RDT/cm/uVeMkVgiDkDr6fnbMbZ6dLzcWvpeOCf
         I/wl9TOZFiq0f+t4sShe9RtiLLeK7E43b+IcUJlp4drziF95FFxkXUShNa469IIqUx1v
         Hnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=J9w4Uw+mJQZ0qiMoimYZNyfJ80DjkGzw/tF6TsleD38=;
        b=dVctfNhCkEMp8dXrS0y9grU01qo7habu4ovSDumnLTA+GMoBGPK3H7hb+5d1Uc2o4E
         /HMoUvTy0PnmSjxz193OimX3HZlLQ0Mkv5j2M4595igMmo+9y5pe5YpGFTlU+hXpAM9v
         o2Zc6i6cHOud5g9NauEmRpW9DXJp0L3Xiltp0osz6YSThk2WQMa5oFm7UB2UEfgj2emO
         yK3yWESVWTo7HyYAKt1GONEG3iyvTsh0msGMX/7BtzMk1GMyv8vABBQQUreZG4laCZh1
         pGycmQwvOdDJW9gkBhF5vgvbL61OCKQoSYpBnUnH/VgXxfGW2V748Nmstwd0XULphYz0
         DhSw==
X-Gm-Message-State: ACgBeo0aCJtxORZyIXqvW9liLHdvg8W3GdCgv/Mpb8nwfp9eatE5re+K
        o7kN+N68o3ee+pvil8Fn3ClkpEEYR1M=
X-Google-Smtp-Source: AA6agR5dxhOfUrPrecnB4/fpHTX8ys+j3CMnLHd4fY06zaGZbe3LGy3gneKFGrofLizNc7DRCbMscA==
X-Received: by 2002:a05:6000:711:b0:220:63a5:954c with SMTP id bs17-20020a056000071100b0022063a5954cmr11656927wrb.667.1659975324486;
        Mon, 08 Aug 2022 09:15:24 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a3278d5cafsm18330370wmi.28.2022.08.08.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:15:23 -0700 (PDT)
Date:   Mon, 8 Aug 2022 18:15:22 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Message-ID: <20220808161522.GA4497@elementary>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
 <20220720173656.GA3725@elementary>
 <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
 <20220720175444.GA10744@elementary>
 <3cdbcfe5-bb7e-2677-730f-f250e2d33f0c@gmail.com>
 <20220724110509.GA30492@elementary>
 <f05e0c92-a1c9-f517-e1b4-f753e362dfd4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f05e0c92-a1c9-f517-e1b4-f753e362dfd4@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:44:29AM +0300, Nikolai Kondrashov wrote:
> On 7/24/22 14:05, José Expósito wrote:
> > On Wed, Jul 20, 2022 at 09:13:39PM +0300, Nikolai Kondrashov wrote:
> > > Could you send me an email once you got something ready for review?
> > > 
> > > Thank you!
> > > Nick
> > 
> > Sure, the PR is ready:
> > https://github.com/DIGImend/digimend-kernel-drivers/pull/598
> > 
> > I included the patches present in "for-5.20/uclogic" but not the
> > patches I sent during the last couple of weeks to the mailing list,
> > just in case changes are requested.
> > 
> > In addition, I created another PR adding the XP-Pen Deco L tablet to
> > the web:
> > https://github.com/DIGImend/tablets/pull/52
> 
> Thank you, José!
> 
> I finally made the release:
> https://github.com/DIGImend/digimend-kernel-drivers/releases/tag/v11
> 
> Nick

Thanks a lot Nickolai :) I'll keep an eye on the bug tracker just in
case.

Jose
