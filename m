Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4962F46DB30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhLHSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:39:03 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:43597 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhLHSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:39:01 -0500
Received: by mail-pj1-f42.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2805954pjb.2;
        Wed, 08 Dec 2021 10:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iRb91wcfGIDc8fcHqi52mmmZ+5JRO93HKexzRfoxhTw=;
        b=0sbGFfynF9CJ/gGBKFUUmN5nV2uCaw8VHIT6oPg+JkKmB7/izD8FT6eQSc+Ji3+fgh
         zD4HMFYmzYyECpyQf4G1E6XE/uJ7aZCyEMKO0i0Ovh1QiirHne8jRVSb60ETqFlFh+CO
         ecjJ+IJkDC1tQvlAeG7V9ndRdgNOqAJHbofArWgfJ67YU5RKKf+KlilcxbfLfcXEiqC0
         7HyoWDf9fZ19nBKZMqLT9qQGJOEpS0XPfTC5xAQQ/hu1Qf3f5mcli6hIjZRFAVnEA3Iq
         oLv/CGXevjI7FS3/YddtQSPiTFdTROJhxcTBSOU9r79fqjSEi9pZyx7/MvJ1VTz5XvLf
         KuoQ==
X-Gm-Message-State: AOAM533AlR/ceYpQ2iVcsyvI1xpsV2ZNeT/vpCpblCoA9ILy+ckN1IOE
        DiTS/BVDf+5ZpYgUVEaVk2tkse1hNpY=
X-Google-Smtp-Source: ABdhPJwWKyyuwJcPF6t+KrhFcMVvum6dWIO1YIUA1g4+Vz2/S5LJBnBRkyx80vYcDtc89Z3yF1erJQ==
X-Received: by 2002:a17:90a:bf8a:: with SMTP id d10mr9110777pjs.67.1638988529056;
        Wed, 08 Dec 2021 10:35:29 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:18af:8865:db7e:6769])
        by smtp.gmail.com with ESMTPSA id h8sm4633810pfh.10.2021.12.08.10.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:35:28 -0800 (PST)
Subject: Re: [PATCH v2 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211208005640.102814-1-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <32b52a87-7616-a128-bb97-b73e2125d84a@acm.org>
Date:   Wed, 8 Dec 2021 10:35:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 4:56 PM, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.

Thank you for having done this work! Once my two comments are addressed,
feel free to add the following to all patches in this series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
