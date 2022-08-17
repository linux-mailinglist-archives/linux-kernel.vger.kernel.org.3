Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F3596A53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiHQHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHQHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:25:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EB6B8F1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:25:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l64so11315496pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc;
        bh=64K04OIAsAM/hqlePyze1mYqqu+ttGsmCQGJcVaNhOw=;
        b=h8J7r4LlIg1NdbOyQu+4uqKXnnVPaRRcxJ2IoLFOgyis0krpp7/so2YqMCwBcajM8A
         nRg2k05ECFLf7bUNAfFJKeZOXEbv3AIVc6P9iWVqbC0ZDLhX98YjMIh1/bZkpjcA1i/P
         oFvxJz4KUOj6O0zNcAhdXOEJeBidEAZ5f5mtKlC5AkFcQjuWN5WgQO2TWKSY2Gy8+yuo
         NyVnF+UEC/x5H51PmdrerWn7uKfFb93TiWOCUqAZ7HYJe+eW3L479C/HnX8cxxLY0Faw
         jwGBVwOZ0OfE6I1BsVX2cKIcTzq2YQ/vaecAXckZnbop7Dl0F6QZpXb/fRD+AnZJT3Kp
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=64K04OIAsAM/hqlePyze1mYqqu+ttGsmCQGJcVaNhOw=;
        b=vxKFfZgrwW7+fbRNvuq7o6ylCqmfSHGeluiz5AeLQSjpC/6tL1O/SpNDpfrP0ZTtWl
         r/8GxKwN6suTPgf12Cm4DgQ5e2oviUmGyaj21XlUAZKUWPtSE1NQsLC4uAIGxaW4duF1
         AMTgjzrT9ozZ9NhJfd3L0BJQHx/uunAVgQXc0GBM35u/RbfUVHzGMUDyGxtPWsPDoRJk
         kOffv2woRQMmZiAYAOc1r8onC5WMHrISj5vvX7vl3qcKvveRmaCK8xJXwEfdQGfZqYe2
         Y8uOx4H4mcHjC9p8E9xfuYalOuWQfozV5jSlQuOqq4nPZdhmeWvG5uyUe6aGDQCG+FZE
         eulw==
X-Gm-Message-State: ACgBeo2X/fgv0Vc4pSXogKesHAvky/jZOpZtGeKatHVCTKAsdbOGUqfQ
        zlIm1evRHd3OrCice08j+XIriAHWagY=
X-Google-Smtp-Source: AA6agR6Oiwb8hLjkIeXhquUAGFHXE09FyiPgzxcxeXa06gNEgirQcwGSmkYu4JCZ4Wn9UfUllTS+eg==
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id be9-20020a656e49000000b00429cae6aac6mr1889023pgb.268.1660721109715;
        Wed, 17 Aug 2022 00:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([103.230.104.51])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b0016dbdf7b97bsm638846plz.266.2022.08.17.00.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:25:09 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:25:02 +0600
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
CC:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v2 linux-next] Remove Unnecessary TODO
User-Agent: K-9 Mail for Android
In-Reply-To: <a92f5041-9630-66ee-1757-4b58bdaabe90@linux.intel.com>
References: <20220816175954.5259-1-khalid.masum.92@gmail.com> <a92f5041-9630-66ee-1757-4b58bdaabe90@linux.intel.com>
Message-ID: <7B894BF2-45AD-44A1-91CA-5380B5DE4657@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 17, 2022 12:31:20 PM GMT+06:00, Pierre-Louis Bossart <pierre-lou=
is=2Ebossart@linux=2Eintel=2Ecom> wrote:
>
>
>On 8/16/22 19:59, Khalid Masum wrote:
>> The capabilities enabled for multi-link are required as part of the
>> programming sequences, even when a stream uses a single link we still
>> use the syncArm/syncGo sequences=2E Therefore the TODO is no longer
>> necessary=2E
>>=20
>> Suggested-by: Pierre-Louis Bossart <pierre-louis=2Ebossart@linux=2Einte=
l=2Ecom>
>> Signed-off-by: Khalid Masum <khalid=2Emasum=2E92@gmail=2Ecom>
>
>the title of your patch should be something like
>
>soundwire: intel: remove unnecessary TODO
>

You are right=2E I shall send the patch with the title fixed soon=2E

-- Khalid Masum=20
