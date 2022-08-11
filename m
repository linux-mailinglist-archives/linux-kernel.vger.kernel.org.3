Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5A58FDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiHKOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiHKOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:02:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FC5B7A1;
        Thu, 11 Aug 2022 07:02:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso5488160pjo.1;
        Thu, 11 Aug 2022 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vrnKifM0ZLpSw/+/Sb/S4IABPEo8OepBaLUHpQMQ85o=;
        b=Fkvbms9kFV3Pibqo+Vrckm0kZEPkcNv6zqu5uIMBQavoc0SPZK/cBoN2rOMXSwEEIQ
         HTqPkzgLsVDojGvM4/uBYyVtgDelCM01DXNuFucSEXJ7cIlOhVWDyN9+7iaGd+m2a8av
         ptI8P/Nzv8WSqX9K8YE46EewUqHj9gcnbCRXVBvLvIP2q+XGsuoRpK9DfpHy8VxP50in
         dFML/lerIDQFozlbPDhuRd96zJjyvYCmyjIBsSx5gcXWsYBvnSOA6p3aJvfNhiYN+LgR
         gHJ1KRq/UwK71otqJQ5S7Rc4kxbUGD7blamPzj3CJJW6rEoaTHusQ4muw75VHS91uL8x
         MOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vrnKifM0ZLpSw/+/Sb/S4IABPEo8OepBaLUHpQMQ85o=;
        b=WWfmAosGz3rliOUdCP2S5mJDxH3UeWgovLyAeqAumvEpr3YQ5t8S9yHY0mGtjCKxY1
         s/jhyXUqc2nEKeMp1kq63vNTxAREBYHIht9Tow9YIXa6NOZMD1ntiRegGyCBnRYQFL01
         FOVLPzPFrjd9UEfirfaF243e3CWxEGOO7O3pbEIxNqWOo//fgrw6D/YGpfHouwT7QR/t
         XJ4FbruOQk2aa64CrnXsimLmvgwn82IughTgEBI6krFKW/N1JcoC2lD0gwpLmHQsVuvJ
         YB1aBVIQNJbH4Ap1zoTYHOxfovatdlYrUbVrNy8oSid76yPX5L0ecp08GTUcDwqNUZrY
         cejg==
X-Gm-Message-State: ACgBeo3WC2gwUqZvchvOixZ/rzHsfOFj1lRiI9exwzMWxjkjkFJh1LC3
        p/U4GNk/YssJ3Vg9kYwJel4=
X-Google-Smtp-Source: AA6agR7zj66dhmm11daztLHp3MA83nHVe9xBPvkuQo/mEMvIIpbZoc4I521AlVzHw3fG9Ic5h/rT4Q==
X-Received: by 2002:a17:903:447:b0:16e:cbe3:29de with SMTP id iw7-20020a170903044700b0016ecbe329demr32457479plb.65.1660226543723;
        Thu, 11 Aug 2022 07:02:23 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm14979500plg.254.2022.08.11.07.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:02:23 -0700 (PDT)
Message-ID: <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
Date:   Thu, 11 Aug 2022 22:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [RESEND] Please consider name next Linux release "I love Linux" (Re:
 Linux 5.19)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Cc:     linux-next@vger.kernel.org, song@kernel.org, wei.liu@kernel.org,
        jszhang@kernel.org, chenhuacai@kernel.org, guoren@kernel.org,
        xiang@kernel.org, chao@kernel.org, ming.lei@redhat.com,
        bhe@redhat.com, longman@redhat.com, wqu@suse.com, yhs@fb.com,
        haoluo@google.com, decui@microsoft.com, siyanteng@loongson.cn
From:   Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/8/1 05:43, Linus Torvalds wrote:
> (*) I'll likely call it 6.0 since I'm starting to worry about getting
> confused by big numbers again.

Could you please consider name the next Linux release (5.20 or 6.0) "I 
love linux" ? The number "5.20" is a wordplay in Chinese, which means "I 
love you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.

Even if next kernel version is 6.0, I think it's probably a good idea 
for both Chinese-speakers and non-Chinese speakers to express our love 
to Linux Kernel.

The name of Linux kernel release has a long history of play-on-words 
[2]. For example, 5.15 is named "Trick or Treat" and 5.17 is named 
"Superb Owl".

[1] https://en.wikipedia.org/wiki/Chinese_Internet_slang

[2] https://en.wikipedia.org/wiki/Linux_kernel_version_history

Thanks and regards,
Zhang Boyang
