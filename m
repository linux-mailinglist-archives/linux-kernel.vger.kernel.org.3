Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34C349AC28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353798AbiAYGHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S256035AbiAYFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:20:12 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D736C0E5315
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:43:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i8so17159948pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hqb18lApb/EFs0zyR5xR3AKweon3zrpFVJcMur2wQdo=;
        b=oO7BhMsRUneAngIb6wlqB5HdF/xeGN3DL6ZG/u6ECkSxMoHNPpOOfAxzqAVgDtaT4n
         BqgVUmMg7H/tUSffs8I7Gu+5usatPhZmWCP6dwG5G66u/ppefFTP/PzhcbM+ahaNgq3m
         buQUbZQoUcLRALeKNkHYbuTNLU9Dxu0PcIcBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hqb18lApb/EFs0zyR5xR3AKweon3zrpFVJcMur2wQdo=;
        b=HYldWPkfqHr9UuOTfZU5ESKPRrf6uwzxPHPzqHg9CU7Gpm3Pyn/Byxuqb/2uyWvMHX
         wrYf4JoO+wmNgDYgw9OtEJxDM23bf7opBq9cwwDWvaGbAowfB19N8IQzIxsMpVrK7mkm
         W5cx9eDtSBrHsUusFY+1jsINKAH8FOFKKMPFGLAN1Uawh7rWChrpxd7EHckJOa/23rxM
         g8kElVjEdm/jwgzkBHtQzXh4vPhdJ2Hz2AdRuJbUZGhRrqkNRPXsWq5JvFrSZltxzBnL
         85uZDlg52wTP2p8aOP1GYaHG8R/AYUinmiemyS5bCkm/Mwo59EH8jZQ1hUKsZnZvW0YP
         fMYg==
X-Gm-Message-State: AOAM531hXcGqFxgENfFCZcbuQZ9dZ5EBwOZ8lpdDuEj2lnRc9dX3FoTH
        IgIK8bY0f5+uZfieitMFPj3o3g==
X-Google-Smtp-Source: ABdhPJwYG5x88nJPkog09GJ1OJns/HDR/CaUdlxBNhDCDDEWbRfi9mn7oaVXJoVP7XPSNW9ZK0FocA==
X-Received: by 2002:aa7:8218:0:b0:4c7:ef9b:8151 with SMTP id k24-20020aa78218000000b004c7ef9b8151mr11663250pfi.77.1643082225441;
        Mon, 24 Jan 2022 19:43:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p18sm19244628pfh.98.2022.01.24.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 19:43:45 -0800 (PST)
Date:   Mon, 24 Jan 2022 19:43:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201241938.DA2AB1AB4@keescook>
References: <20220125142430.75c3160e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125142430.75c3160e@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:24:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> 
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_messages':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1934 |                                         crq->valid = VALID_CMD_RESP_EL;
>       |                                            ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1935:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1935 |                                         crq->format = cmd->rsp.format;
>       |                                            ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1938:52: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1938 |                                                 crq->status = VIOSRP_ADAPTER_FAIL;
>       |                                                    ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1940:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1940 |                                         crq->IU_length = cpu_to_be16(cmd->rsp.len);
>       |                                            ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> 
> Exposed by commit
> 
>   4ba545781e20 ("Makefile: Enable -Warray-bounds")
> 
> Probably introduced by commit
> 
>   88a678bbc34c ("ibmvscsis: Initial commit of IBM VSCSI Tgt Driver")
> 
> I applied the following hack for now:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 25 Jan 2022 14:18:36 +1100
> Subject: [PATCH] scsi: hack for building with -Warray-bounds
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index 61f06f6885a5..89fcf98c61c3 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -1872,11 +1872,11 @@ static void srp_snd_msg_failed(struct scsi_info *vscsi, long rc)
>   */
>  static void ibmvscsis_send_messages(struct scsi_info *vscsi)
>  {
> -	u64 msg_hi = 0;
> +	u64 msg_hi[2] = { };
>  	/* note do not attempt to access the IU_data_ptr with this pointer
>  	 * it is not valid
>  	 */
> -	struct viosrp_crq *crq = (struct viosrp_crq *)&msg_hi;
> +	struct viosrp_crq *crq = (struct viosrp_crq *)msg_hi;
>  	struct ibmvscsis_cmd *cmd, *nxt;
>  	long rc = ADAPT_SUCCESS;
>  	bool retry = false;
> @@ -1940,7 +1940,7 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
>  					crq->IU_length = cpu_to_be16(cmd->rsp.len);
>  
>  					rc = h_send_crq(vscsi->dma_dev->unit_address,
> -							be64_to_cpu(msg_hi),
> +							be64_to_cpu(msg_hi[0]),
>  							be64_to_cpu(cmd->rsp.tag));
>  
>  					dev_dbg(&vscsi->dev, "send_messages: cmd %p, tag 0x%llx, rc %ld\n",

This looks correct to me. struct viosrp_crq is 16 bytes wide. The only
suggestion I might make would be either avoid the bare '2':

	u64 msg_hi[sizeof(struct viosrp_crq) / sizeof(u64)] = { };

or adjust struct viosrp_crq so the casting isn't needed at all:


truct viosrp_crq {
	union {
		u64 hi;
		struct {
		        u8 valid;               /* used by RPA */
		        u8 format;              /* SCSI vs out-of-band */
		        u8 reserved;
		        u8 status;              /* non-scsi failure? (e.g. DMA failure) */
		        __be16 timeout;         /* in seconds */
		        __be16 IU_length;       /* in bytes */
		};
	};
        __be64 IU_data_ptr;     /* the TCE for transferring data */
};

	struct viosrp_crq crq = { };
	...
 			rc = h_send_crq(vscsi->dma_dev->unit_address,
					be64_to_cpu(crq.hi),
					be64_to_cpu(cmd->rsp.tag));



-- 
Kees Cook
