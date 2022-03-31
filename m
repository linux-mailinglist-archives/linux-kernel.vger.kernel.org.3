Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64994EE12E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiCaS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiCaS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:58:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283D19CCE5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:56:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x4so587546iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+g4ZNpIxBnSkme/wNFOytxoH6v9mTIXDnbrIqG4r6aY=;
        b=EvHbhnlW2WmAIO20yqRruynjvVlKl5NzFw6BsDBjCNtXz5Ihn4uGH0sfXRAG6xqBn7
         JfJ+09677YCnAxT2G/pWFkysXOs9IpbBbwfMAW+R3krXaWCQZj+f1VmhYpqBYaTR5/M2
         mO2nbkChoZpTexjArhRoOffq+FFSutfl6dVBgYwiHoQ/OGe+RId06zBQcztWdiug8g/R
         vqLkIj8efE4sNFevzht/Y/g2BclZPdafECHPSOWjfSVTfCNMKvUDb65pP0IlTAoSHYov
         tcYuNuWpbXxelZI0j/CdAckDCt0xArsffjmD3bE7RFfdIrIOj1/yzZYENjgvmMlDzAB3
         tDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+g4ZNpIxBnSkme/wNFOytxoH6v9mTIXDnbrIqG4r6aY=;
        b=whsVBHR3xHckr/qm3/QCDcVuGlNJqCQYBTqIBrDu0f4th4OlfU54uO9VDzd/5bqN7H
         hYT2O1DEuuXrR5Y4jteUE1FL+gSQ9OcDb0rpLmF1E+uvKau98xItGiN6L+3ooEKlxkdU
         PGIbrRf0Lf9wdXkCuHwf9I8QFVLXsDG1P+ro9iFJqhZtZMf6ktRn0Mw/zR65hZdKNsx6
         vnDWMhc2DxgPk2aAE5DJ3kMXuoUt6TVp06MBswC8NUKr86mO7Q2zwqb8HKrAfgVyxBGv
         lorfQq2rDk/bdRmix/NVekDUcszbClrcnmoUNY1xarg85ie78+t2X8gbaQH4odaq0FdZ
         WHhQ==
X-Gm-Message-State: AOAM533q24GW78rGeJZGoEhc1g4dmdhJ4+AQiiXnL24WEWWOWrVCoBQV
        B1KH1PKSbOp2RE17KYRpMZB3wQ==
X-Google-Smtp-Source: ABdhPJzc0hwAInyQ3w0FQhKRTQnho2kqwyjIN5xbQ6E8t46bUjtOOVOI5AqaleePK/Db7WFYguHCLg==
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id ay40-20020a056638412800b0032362b430c3mr3999511jab.318.1648753007479;
        Thu, 31 Mar 2022 11:56:47 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p3-20020a056e02104300b002c9f5a5cb7csm126515ilj.42.2022.03.31.11.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:56:46 -0700 (PDT)
Message-ID: <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
Date:   Thu, 31 Mar 2022 12:56:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-wbt: remove wbt_track stub
Content-Language: en-US
To:     trix@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331185458.3427454-1-trix@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220331185458.3427454-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 12:54 PM, trix@redhat.com wrote:

Not sure how you sent this patch, but there's no body, just an
attachment. Regular tooling doesn't like that.

-- 
Jens Axboe

