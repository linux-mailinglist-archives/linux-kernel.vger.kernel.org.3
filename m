Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7D576E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiGPNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:47:52 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24B1C123;
        Sat, 16 Jul 2022 06:47:51 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso8558304pjj.5;
        Sat, 16 Jul 2022 06:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HZJ/936nVqNWje7AIbkFDRvOjSNDHlER+myfiO44S5s=;
        b=D6b9doYjkv94W8YOnJAPRfaEoUWUUW2uE9kQqPwmdq9bHnfez7V8hDYfN0JzQXsnKv
         wTbNy//plC211hv8OImXVplpbReLM6Gq8mg5Icp2PMXhDO1h2f46aoiWWvV68nA5Fz9p
         cWar/D8PeVix1tU32xuuZ+Q/WF8U9oGtPvRhygGR/73voln9P9cvva5bsSuFX17OTHI5
         Q5n7aSx+XvVFlO/IKjQJjsODCdafEO4kDeeI42SizNRYZGBX0cJBCtCXggKXxaYE6I5C
         on5KGf11l5gZM8TgMzZl6lemwUdfBQOLRIdKT83Pf/g/OTGg6cijpbNa7a3U2kpc7VqH
         vmxg==
X-Gm-Message-State: AJIora9m5bWU+45A8SZEpNcFsCTf4l0+BYHjLLdtlXSp6GNYeQ7R/51s
        M9ryh0KCo6IWT2LHxKYi4yQ=
X-Google-Smtp-Source: AGRyM1ueVGzx1JynMTAYjgBHKqo/W3Dc8DGsBZh608L+B1fV9sFh9pj881mXq63v7ewB2+2lhjYW6A==
X-Received: by 2002:a17:90b:3e84:b0:1f0:3f92:8c91 with SMTP id rj4-20020a17090b3e8400b001f03f928c91mr28827478pjb.112.1657979271310;
        Sat, 16 Jul 2022 06:47:51 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902c2cc00b0016bff65d5cbsm5551489pla.194.2022.07.16.06.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 06:47:50 -0700 (PDT)
Message-ID: <434e296f-dc7f-2a65-e7db-643e89e492e0@acm.org>
Date:   Sat, 16 Jul 2022 06:47:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: qla2xxx: Fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com, njavali@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220715071735.856293-1-13667453960@163.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220715071735.856293-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 00:17, Jiangshan Yi wrote:
> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
> index 3f3417a3e891..b8a9f923fb32 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -6661,7 +6661,7 @@ qla2x00_loop_resync(scsi_qla_host_t *vha)
>   * Description: This function will set the appropriate flags and call
>   *              qla2x00_loop_resync. If successful loop will be resynced
>   * Arguments : scsi_qla_host_t pointer
> -* returm    : Success or Failure
> +* return    : Success or Failure
>   */

Please convert the entire function header into kernel-doc format instead 
of only fixing the spelling error shown above.

Thanks,

Bart.
