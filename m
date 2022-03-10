Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705FF4D4023
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiCJEIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCJEIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:08:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B727487A;
        Wed,  9 Mar 2022 20:07:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so4115009pjl.4;
        Wed, 09 Mar 2022 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lOGsKXR40MzrVcMHWeC6U8EP187W1cfPMllbU9spfy4=;
        b=d7SXPpbqzZKYTwjwgiswjOYgBLV2yzAX6epBBVnzbsvzqfkbqsv45dSgDabXv+Ww4R
         eEdK5ZY4qxdWrTm43XPt/0xRBv5Pc+oXe4eRUlAEGHLoYFMPgQJTPuksVAipGrsDgCCe
         mSm+nNrJuOEw5OOM/bVZTfBUAK3l8ibzuP8dA5ktGGPv1vsekyCw0ZAwDAUOcKpEBCWN
         94v7iArjTMpWmkSj+2xUimKDXiapWSZ6ZVhmF7tmrItbuQimRq4Kxv+vFRt5qMlPrl5v
         lRs3aHrbw0OZotvO6GuQHXp7zON2mXsgp18ZObafKdAU/VWjB254Uvj2K+YTwCGna5R0
         a/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lOGsKXR40MzrVcMHWeC6U8EP187W1cfPMllbU9spfy4=;
        b=nUL0zUf/ewJ3bEehvWrdGTt8b9whPND3krbT7L4QQEyYJ7x8qXaFfph5ENBBnTgKHy
         fwQQfw56rIFgnLI0je1idp6DuvnMNri1IOCdweTMldOL2H5fcdiHZ8VHbBsHyH4H6mUa
         vcKGliRtaTJUGrk/sHG+h1JaHkgsrh3jQIDIFeVQ8AQRjIKPAqFehPHWNiOcuRZk/7r/
         Vrjwj+PPAO2x3p3yMb9JGg0Gp2H2b25QAJZePZ3zhmIZHuj0DzIqn8omxIJXTVNAp4op
         FXcgJZeB1d5sa1iUZcgOjbDAa0k/lQNZqFWdOGPLEn8qc4BN/3mBBD3rvcGTfuQd7fmX
         EJ8Q==
X-Gm-Message-State: AOAM531hMglLWz0C52TYfhLn0+7vea9wRvSwD/elB7YLZpb9JM4YTY/E
        WfRmZuDmhwpEXFtAJr6LaUaCBRUCMTI=
X-Google-Smtp-Source: ABdhPJwLY0RJraH7XmAsX5Ei/ShC0xAnGUWkGghiC29+Cx21rIozy0GcStFFB36LfBDaRKvIOwpgNQ==
X-Received: by 2002:a17:902:f145:b0:151:a441:433a with SMTP id d5-20020a170902f14500b00151a441433amr2939864plb.44.1646885270738;
        Wed, 09 Mar 2022 20:07:50 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-60.three.co.id. [116.206.28.60])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm4995550pfu.106.2022.03.09.20.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 20:07:49 -0800 (PST)
Message-ID: <9c2ea46f-57f9-29e6-7232-c2482acfed15@gmail.com>
Date:   Thu, 10 Mar 2022 11:07:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] Documentation: describe how to apply incremental stable
 patches
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org
References: <20220307063340.256671-1-bagasdotme@gmail.com>
 <87mthy7lif.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87mthy7lif.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 06.29, Jonathan Corbet wrote:
> I've applied this, thanks.  I do have to wonder, though, how useful this
> information is anymore.  Does anybody actually apply kernel-patch files
> this far into the Git era?
> 

I think most people don't use Git to track kernel sources, so they just
download full tarball from kernel.org, then applying stable update
patches (normal or incremental). I also used to do the same, but now I use
Git because when there is stable kernel update, I can simply `git fetch`,
then checkout desired stable branch, and `git merge`.

-- 
An old man doll... just what I always wanted! - Clara
