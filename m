Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098E8487DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiAGU6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:58:15 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45000 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAGU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:58:14 -0500
Received: by mail-pl1-f174.google.com with SMTP id h1so5744729pls.11;
        Fri, 07 Jan 2022 12:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oGg6eEoyVeP3AsWSET5vQXpARWWBJj2efG9QJ7/Rr00=;
        b=YLVgqrl7Y3kn2OILpy1lQy7qFiX5L2mXexV+eUyY4cW3XCmpkxmkmcXZEgSHc9ceYS
         tdG/zb2pJ65H6pM/ddwqqVU7gMPA6zjTFt4obrremJF+s2cENKomhbXZGBRnknylmm1n
         5zdJfZ0HvaUymBiqfNZNFA4uTkee+JFVrS0OD/Lxh7yhuLTalX8AWTloZ9dIt3rtLoRs
         JKDPICgv9+wR41RJ6EKty/lTb4KuM3atiR2Gr6E/kaiHN51uJr2dh4F678b+XmXTNFyf
         dM92yrbf5WuwJiiH4nCETPsEPdwtmsczWxtCcdOaLOZQ5zbz2L71FX7PkzogVHlQ8AOk
         Bfgg==
X-Gm-Message-State: AOAM533xe9Lrf14O04w7D0baIx4ADRu8iAz8Pj3TlNvZkDh6rTcmZBL2
        17GQJ1BnFoHJx+spuSTBYmk5Pn3Dlkk=
X-Google-Smtp-Source: ABdhPJyZMDQwYg25LmbxhXmRoavew5HZXicqdbehbXyIjNxXyVMTLPDIQSJ5/cpns4UpDcSoMLYYYQ==
X-Received: by 2002:a17:903:1c4:b0:149:45fb:d6f0 with SMTP id e4-20020a17090301c400b0014945fbd6f0mr63257885plh.143.1641589093673;
        Fri, 07 Jan 2022 12:58:13 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:d201:bcd0:fc75:8697? ([2620:15c:211:201:d201:bcd0:fc75:8697])
        by smtp.gmail.com with ESMTPSA id l6sm6840272pfu.63.2022.01.07.12.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 12:58:12 -0800 (PST)
Message-ID: <65376e36-579b-76c4-0642-4582d6679914@acm.org>
Date:   Fri, 7 Jan 2022 12:58:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark> <YdMQ6rfSZWSOLptA@quark>
 <YddiJFr+ba7Veh82@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YddiJFr+ba7Veh82@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 13:41, Eric Biggers wrote:
> Jens, any reason you haven't applied this series yet?  It looks like you've been
> applying other patches.  To be clear, I've been expecting that this would go in
> through the block tree, rather than the docs tree.

We are close to the v5.17 merge window so this is not a good time for a maintainer to
apply a large patch series. If Jens does not reply I propose to repost this patch
series after the v5.17 merge window has closed (three weeks from now?).

See also https://lore.kernel.org/lkml/CAHk-=wg=3dEpPGhz8YvJUDWhFW_GUeASBGmqyw3aPQRfB3ki9w@mail.gmail.com/

Thanks,

Bart.
