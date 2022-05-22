Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D15300C1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbiEVEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiEVEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 00:36:34 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C13587F;
        Sat, 21 May 2022 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=C/l6AnCrNdM0sxAoPiPcgRGGIIZVhapGBcAM8SyyoWU=; b=sA8UXMyyD6nH9C8x74BoU4iwZx
        4J+yjV/KR5UwrGsTlHW8QuxKW+rs6w5TCF0Szpnff1ziG15AxkSAqPKs8Cdy5WkeOyFVp0fCCk/an
        qc4e2FJYoQsKnhTy0ihUzInALzpUL0CXwD6c94Ftybp/jjcz2SJz6qZf/aNMFXIoSDyZl/PX2QPUG
        4fJjLinn8z1wZwCh6XgnnVZcgXHBhUHWYK6siGxm9PJBMSc8p+8s6kpFAxSvEpSg4HpDVoOPVYIOU
        EyJ375gkaX2FP9yur9RcJW1DMdyh4l3FyGfBt4AqScrZWab68unBRxpardRuDevympjdRznW97kGr
        YOUd3m7gVyDqdKjC21l5iPYe8FATuj05k5cNvrGQHw2vJq/pyKfAJnMW6kjaDbcLexrAYuQOp+i8Q
        FgcRW73HJpixVKLXF7RL4hkj7TtuPHczzeRazfSZ5dVil2YMmftoXmQRIgn9iyj58PW+wyKLVJv7T
        QqtJ6hvVan7wFRf0rkXNyiuN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1nsdKO-001xvK-9f; Sun, 22 May 2022 04:36:28 +0000
Message-ID: <c530769a-cdbc-eb33-3931-a8fd64e683c7@samba.org>
Date:   Sat, 21 May 2022 23:36:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] cifs: smbd: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
References: <20220521111145.81697-69-Julia.Lawall@inria.fr>
From:   Steven French <sfrench@samba.org>
In-Reply-To: <20220521111145.81697-69-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On 5/21/22 06:11, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>   fs/cifs/smbdirect.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index b3a1265711cc..c3278db1cade 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -1350,7 +1350,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
>   	wait_event(info->wait_send_pending,
>   		atomic_read(&info->send_pending) == 0);
>   
> -	/* It's not posssible for upper layer to get to reassembly */
> +	/* It's not possible for upper layer to get to reassembly */
>   	log_rdma_event(INFO, "drain the reassembly queue\n");
>   	do {
>   		spin_lock_irqsave(&info->reassembly_queue_lock, flags);
>
