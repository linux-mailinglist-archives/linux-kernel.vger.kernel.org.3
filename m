Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E501552AB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352352AbiEQSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiEQSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:46:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA1387B1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:46:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f4so20249235iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YIMbxTsLbrtbEFkaDSucwQrnGbAU6ETE/HBk7HXw4BM=;
        b=ASYaeDqOr6ZY8Y43feyxwUMnrIDRCO57Y0tCwbWFl1fPRaCrgk/PQQRdq2efcvraln
         /X+FbfFi9Q7SGYrJGRc0XaOjGtseOysVsi+cTdhgdSw1qncp9S3OgZB5D6DbqMyiJ5hN
         86YVYr8OEX0vDEhnAx/TE5NQmgBAFAwiHUMFkJ37NIGbDJ70ANJQWV1RjiSHL8rUc81z
         x3WLf6UbNTuBElaOYFc4+qMVk9N8FDx13MuSQJ2yk4WG7UtrEW81OFX7nRoxlOooDEUk
         Q0b5EjP7m4bBifoBEtc0mcnsvU18uL2OjPW/kEmoXC36Mo2Clp5Bl/Gr/WczDz9LUWtq
         GmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YIMbxTsLbrtbEFkaDSucwQrnGbAU6ETE/HBk7HXw4BM=;
        b=cu6aaaKP19iZ/ebgOsKCNMyV8GgcaRgxwbKTiMQbJnvjlj5E/1RFcG9He9PC9/mZdl
         aOA57qY0fag1KQ3rb/MOroHHM+pDyeJ1y8YAVWdT4+QaQC8OmNz6jMrc+HISFyo6UA8g
         SWXHyB04dUXJgFZfkviiv0IsMX1lJcbr0u08e45TliBCvcJp1G4hxpC6Rrh5kmheKZmX
         UPI6W7wSzBndfr+cd9TBt6v2Dsv1jDNdkChXpG/1yQKBE2ig9RbOPDvFTczqQeN/jomW
         DUCMUT+3h0dOE5tRHYY9SLQOInIgjPitf6EHUdRwVgHIayQUhAh3BM6RNIx9o4FW1Zfx
         a6Dg==
X-Gm-Message-State: AOAM533M/JbzKXVxOUof4nxcEPMP7RMts2M6bET/2Fpl45M0S3nx1Fq5
        kacPDwI5iV0W3G2pOZZNlhPi0A==
X-Google-Smtp-Source: ABdhPJwhs6oUxOuuvG3hk5YOfiQ6EgXRITTlIrL7zUmPYKqYM4mtvC+cg2zwyv9nGK+ZbzyvqCoyFg==
X-Received: by 2002:a05:6602:1510:b0:65a:edd4:cdb4 with SMTP id g16-20020a056602151000b0065aedd4cdb4mr10853963iow.143.1652813202389;
        Tue, 17 May 2022 11:46:42 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o13-20020a056638124d00b0032e30453802sm1804804jas.47.2022.05.17.11.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:46:41 -0700 (PDT)
Message-ID: <b6f36795-97ac-fac0-ab07-98de8255e4f9@kernel.dk>
Date:   Tue, 17 May 2022 12:46:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 io_do_iopoll
Content-Language: en-US
To:     syzbot <syzbot+1a0a53300ce782f8b3ad@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c1bd6505df39865e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000c1bd6505df39865e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 12:44 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: unable to handle kernel NULL pointer dereference in io_do_iopoll

Gah, backport ended up putting the hunk in the wrong spot, not very useful.

#syz test git://git.kernel.dk/linux-block io_uring-5.18

-- 
Jens Axboe

