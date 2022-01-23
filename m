Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4196F4970B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiAWJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:16:56 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46070 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiAWJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:16:53 -0500
Received: by mail-ed1-f52.google.com with SMTP id z22so50657752edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 01:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=2fyFS+Y1m2887LqgERIyKSAM0LubJDu9Epu/X8cfikKj9QmnAg3vzBentIBcTSVm74
         rGhaS7/Ax+OggRJ2pzJrDRGKfXszTjAYzGrT3B+9sYIvUCvXKiSHDwtc4OKAO1/oi8+8
         rg+xLWe0tXaCeoYdLx8XR3NQX4XmFXy5eZ/zmHVC0Pho2yzFQegTP1BqDEfsPRI1bqi2
         DhAxmdkTXQdv6lqbb88ojIr3GPzIsbo+i8XF9UCnw22gxHKFMQRYDW/+6W+OIk/1zS7B
         IAbjLG1lNYmbDiveEYz5MSc6ys1RLXh1GNsWbcwSm2lHvMQd9zoGDWccl4vt3IibsWOh
         qKzw==
X-Gm-Message-State: AOAM532WJTD6MVOGORxJDfds5oGIQihbuUeplB9phz+j4MvEOkHnUc/X
        lMcGQy/uDJEAobNDpf0V/n4=
X-Google-Smtp-Source: ABdhPJyroPfnQDhcyUbsYHUCBLYt3vcMzY1QM2dwnvS0gKlL7IS1UHY+k/HyYe/nTILXTOVTS8Qu7Q==
X-Received: by 2002:a50:d0dc:: with SMTP id g28mr10810282edf.25.1642929412330;
        Sun, 23 Jan 2022 01:16:52 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id ch27sm643434edb.74.2022.01.23.01.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 01:16:51 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: fix returnvar.cocci warnings
To:     kernel test robot <lkp@intel.com>, Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org
References: <202201221116.hWZkKqts-lkp@intel.com>
 <20220122031737.GA31599@fba2a898af35>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aa0e01c1-4d3e-eed2-d32f-d1ecb9a97e90@grimberg.me>
Date:   Sun, 23 Jan 2022 11:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220122031737.GA31599@fba2a898af35>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
