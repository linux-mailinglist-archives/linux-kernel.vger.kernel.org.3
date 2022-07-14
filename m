Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB28575020
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiGNNz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiGNNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:55:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8176113A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:52:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso8726712pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=dRLjUTiQCQTOPTl0yY/jJ6h6pURCSE+L6aidbvep7OI=;
        b=SHsen0pbZp9/IJZqYExYxr/I8KuqtcNReumOmnXUCjhsNZcdzM97eQIYFSxY00Sk0J
         AT2ETy4Mqy0S3m9EJt4A4Zy8vbdUSne+KOaxaE25nV3k3XhF0tSzP0WUsprfvXBaiX1f
         vAnmS/T+qeF8iCN6Rr6rafVYuDdERmjfM7ZW2LL9RU7zr2xqu7fWXUkXgblotell2I5M
         oMBpPMhDLRyoo9qdrbeklUkhMZSrzKhtBWvhrZl/sCoXn6/eEro8Jlcxg+L5OVx2K2Nk
         UD6yk5yOrmGs+urVH973fYmBDjArlbF85T8doE1xcqVOtqC+uw7QlpmM8L73qGfJWgMo
         5pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=dRLjUTiQCQTOPTl0yY/jJ6h6pURCSE+L6aidbvep7OI=;
        b=1wpVCg8JAaIkeQK6LckL5JLVI/mBi/1o7rzGCleEo7xP/BYdO7Yz6eax1HAV4zBajf
         g5cWb1OIcnQmFmRcL2WO6MhsOGQt9DF18gSNKT1W9nS6DZtifWU7KaAUeNTwkw1VUQta
         cBMF55r9IKmwPM0Gc1TtNkiAM82U0o9aZlthdTQTfjd0Y+mIBb6botC9E22F45goz90T
         7dsM4N/PXHvhpiW4rhYyT0glqrRlIn9PhqbXEN5I/ms9mjqMUvj79xKi0cpZKlGBwski
         Ovqj2MMUhMzmNJPRrHzmtcEOTb8awUri1ulBCK9gRhrcRtigs7p9RHABac2JKZaY92UZ
         7b4w==
X-Gm-Message-State: AJIora9Te0B56TYHWG/YOC089vFzxkYV2d4hQVph/98wFu205EVweBuZ
        DCOTuq5KV69FJno5jWACpMQk5w==
X-Google-Smtp-Source: AGRyM1uHTeR7seCsmKjUG2nMZzmbbO+jAvtlZFdVXsRaCMTZyLDqTwb3J773pwxK0gu9q4HGJrxzzQ==
X-Received: by 2002:a17:902:e2d1:b0:16c:65bc:995f with SMTP id l17-20020a170902e2d100b0016c65bc995fmr9200419plc.133.1657806734799;
        Thu, 14 Jul 2022 06:52:14 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225? ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b0016a565f3f34sm1486013plg.168.2022.07.14.06.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:52:14 -0700 (PDT)
Message-ID: <31c6f827-65fa-0fe3-6c98-53be585d818a@linaro.org>
Date:   Thu, 14 Jul 2022 06:52:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
References: <20220713185904.64138-1-tadeusz.struk@linaro.org>
 <20220714095300.ffij7re6l5n6ixlg@fedora>
 <20220714122351.vtiai34zvrrg2np2@fedora>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] ext4: fix kernel BUG in ext4_free_blocks
In-Reply-To: <20220714122351.vtiai34zvrrg2np2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 05:23, Lukas Czerner wrote:
>> This does not seem right. we should never work with block number smaller
>> than s_first_data_block. The first 1024 bytes of the file system are
>> unused and in case we have 1k block size, the entire first block is
>> unused.
>>
>> I guess the image we work here with is corrupted, from the log it seems
>> that it was noticed correctly so the question is why did we still ended
>> up calling ext4_free_blocks() ? Seems like this should have been stopped
>> earlier by ext4_clear_blocks() ?
>>
>> I did notice that in ext4_mb_clear_bb() we call
>> ext4_get_group_no_and_offset() before ext4_inode_block_valid() but
>> again we should have caught this problem earlier.
>>
>> Can you link me the file system image that generated this problem?
> ok, I got the syzkaller C repro to work. The problem is that it's
> bigalloc file system and the 'block' and 'count' to free in
> ext4_free_blocks will get adjusted after the ext4_inode_block_valid().
> 
> We should make sure that if this happens we also clear the
> EXT4_FREE_BLOCKS_VALIDATED. Additonally the ext4_inode_block_valid()
> in ext4_mb_clear_bb() should be called*before*  the values are taken for
> granted. I'll prepare a patch to fix this.

Thank you for feedback Lukas. Please CC me on your patch so I could test it.
-- 
Thanks,
Tadeusz
