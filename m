Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07396561FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiF3QFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiF3QFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:05:53 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E612A92;
        Thu, 30 Jun 2022 09:05:52 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id n12so18634072pfq.0;
        Thu, 30 Jun 2022 09:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LfrbuW9OUj2pfh9ElIT7TqP+4P6qIeFOTMCHXFNYd0w=;
        b=ALl1PqKdLWOYVhhr13eJFrno+A7u7n6p5ZmaIP7SnH/IxrCMe/8I0YWFqMnIXxXdEM
         tdTgVWGG3Is+yCPlpR6W4umMxw/3OpM+wz8c/aT/hz+o/1IyGBAYQ0F91IQIXXuq5hy3
         LbPFwJKvvgP3XEV0CwQoVxWz44MAbBJkJMMalcSDkoamEuiln3lQ8PrGbvaCeTSjVNDH
         n/Umb6zfSrCjqScAFfeI1cDkRsC9i834p+GngTeJWLQAiRnVcgAJTrvOl3UTJ4OVlzB6
         0Yv/NpPfV7FoKXav36NY2HvRlIJDdHiV+APsRYmCpg/YWGEMyrSb+fM96TbNJ8+3bswg
         XjAA==
X-Gm-Message-State: AJIora+D42PvktQh4WsJa4ZUStfncz9kf+Q9apQrV3K1kSt7MHMwn8Ni
        QTGPVELR4MoCQTocUcEeEyM=
X-Google-Smtp-Source: AGRyM1s6qGC6kwKStoVI/7tk24MmJChwyhXYi77o4VU9EWYlalfhQTLSUINDcUmCuPt1fmTP8NbscA==
X-Received: by 2002:a65:41ca:0:b0:408:aa25:5026 with SMTP id b10-20020a6541ca000000b00408aa255026mr8675644pgq.96.1656605152191;
        Thu, 30 Jun 2022 09:05:52 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id b9-20020a631b49000000b00411bbcdfbf7sm808144pgm.87.2022.06.30.09.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 09:05:51 -0700 (PDT)
Message-ID: <47120af4-e4be-01e0-3d35-419b8d690a29@acm.org>
Date:   Thu, 30 Jun 2022 09:05:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: Shorten too long warning messages
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <20220630024516.1571209-1-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220630024516.1571209-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 19:38, lizhijian@fujitsu.com wrote:
> sdev_printk will only accept messages less than 128 bytes. So shorten
> the messages exceeding 128 bytes avoid getting a incomplete sentence like:
> [  475.156955] sd 9:0:0:0: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
