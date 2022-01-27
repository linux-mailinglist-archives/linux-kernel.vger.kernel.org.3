Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7349EE25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiA0WiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:38:16 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:56987 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbiA0WiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:38:15 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 9C4BA2B00384;
        Thu, 27 Jan 2022 17:38:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Jan 2022 17:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wcr9somIvzZFXM+do
        LeomZA5zif3KjUFitVyFvJeDYo=; b=Th8UCnAWUfFBauUeRu2r8tL4o/qjWFXUs
        uJjCsIczCIR7m69lw4gcRi3cHWCHzzC1QQKuFLTFPv0YnqVi1xYyYAfnwhn06jqw
        7uKcU+w3jzQMl+2YhuVYJzIBHGbtNFDDJF4Dt8MyuyWrjCUwAoUI86TxUlrljsu4
        o2B3OC13bZ5JEqE02ZVHipmOwadF1NQwqu7oouT8kNj0nvKl24Ny3BVWOUBx8QkC
        F7gGuSyN3QPZYT04TAQ3v8meFfDMy/GNhT0OmXbhk7FH7XLZgkCA5THYqNfDxvMG
        Ntej5cBSoZJJKYvvigCUu1ZSuPm3/IDbkRZXYtpC+wGjpHgxzd+mA==
X-ME-Sender: <xms:1B7zYYVxtd6YEbVnm-4_RCT2C4zKEKMnwFXqMfGOt1upUktoUa_mCA>
    <xme:1B7zYcnv0Bs3WSo_nVJzSlt-NTiRd8gH3boPstx5drM1FCQAV8OuXZzJrl5OYu8hE
    88uWCfqQ7AC64PHKgQ>
X-ME-Received: <xmr:1B7zYcYGEeLRYRQS40-jvSKOLJhHEff8R-Jo-xZSr3-9h3WUOueXMAWjjO70k3K57TsUBN8BdSKd3qrbGxrxoOXz1P4YP9CDe40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeefgdduieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:1B7zYXUywcSuvw1OihWbbXsVHwS0F2KDJIYb0lYQxQ3JfPiwzQMIQw>
    <xmx:1B7zYSlet4_9vf9KIwN0mL5LDMnM-LS3lc3mv8XtdMW-tEbPM_SQ7Q>
    <xmx:1B7zYceJXsy-LSX_JAVQ4HiCZESHrHn1H1T3OIjooV6CuF4gImx8UQ>
    <xmx:1R7zYXjai1E_HJPafK1KO4xThwjq_dU2IjnZ92Ve_7bG49kMyY4asU6_RMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jan 2022 17:38:09 -0500 (EST)
Date:   Fri, 28 Jan 2022 09:37:58 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Tom Rix <trix@redhat.com>
cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <20220127151945.1244439-1-trix@redhat.com>
Message-ID: <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jan 2022, trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> checkpatch reports several hundred formatting errors. Run these files 
> through clang-format and knock off some of them.
> 

That method seems like a good recipe for endless churn unless checkpatch 
and clang-format really agree about these style rules.

Why use checkpatch to assess code style, if we could simply diff the 
existing source with the output from clang-format... but it seems that 
clang-format harms readability, makes indentation errors and uses 
inconsistent style rules. Some examples:

>  static unsigned short int max_sectors_per_io = MAX_SECTORS_PER_IO;
>  module_param(max_sectors_per_io, ushort, 0);
> -MODULE_PARM_DESC(max_sectors_per_io, "Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
> -
> +MODULE_PARM_DESC(
> +	max_sectors_per_io,
> +	"Maximum number of sectors per I/O request (default=MAX_SECTORS_PER_IO=128)");
>  
>  static unsigned short int max_mbox_busy_wait = MBOX_BUSY_WAIT;
>  module_param(max_mbox_busy_wait, ushort, 0);
> -MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
> +MODULE_PARM_DESC(
> +	max_mbox_busy_wait,
> +	"Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
>  

This code is longer for no real improvement.

>  
>  /*
>   * The File Operations structure for the serial/ioctl interface of the driver
>   */
>  static const struct file_operations megadev_fops = {
> -	.owner		= THIS_MODULE,
> -	.unlocked_ioctl	= megadev_unlocked_ioctl,
> -	.open		= megadev_open,
> -	.llseek		= noop_llseek,
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = megadev_unlocked_ioctl,
> +	.open = megadev_open,
> +	.llseek = noop_llseek,
>  };
>  
>  /*

Readability loss.

> -		prod_info_dma_handle = dma_map_single(&adapter->dev->dev,
> -						      (void *)&adapter->product_info,
> -						      sizeof(mega_product_info),
> -						      DMA_FROM_DEVICE);
> +		prod_info_dma_handle = dma_map_single(
> +			&adapter->dev->dev, (void *)&adapter->product_info,
> +			sizeof(mega_product_info), DMA_FROM_DEVICE);
>  

Note the orphaned first parameter and odd indentation.

>  
>  static DEF_SCSI_QCMD(megaraid_queue)
>  
> -/**
> +	/**
>   * mega_allocate_scb()
>   * @adapter: pointer to our soft state
>   * @cmd: scsi command from the mid-layer

Indentation error.

> @@ -418,15 +409,14 @@ static DEF_SCSI_QCMD(megaraid_queue)
>   * Allocate a SCB structure. This is the central structure for controller
>   * commands.
>   */
> -static inline scb_t *
> -mega_allocate_scb(adapter_t *adapter, struct scsi_cmnd *cmd)
> +	static inline scb_t *mega_allocate_scb(adapter_t *adapter,
> +					       struct scsi_cmnd *cmd)
>  {
>  	struct list_head *head = &adapter->free_list;

Same.

> @@ -586,26 +568,25 @@ mega_build_cmd(adapter_t *adapter, struct scsi_cmnd *cmd, int *busy)
>  
>  		ldrv_num = mega_get_ldrv_num(adapter, cmd, channel);
>  
> -
>  		max_ldrv_num = (adapter->flag & BOARD_40LD) ?
> -			MAX_LOGICAL_DRIVES_40LD : MAX_LOGICAL_DRIVES_8LD;
> +				       MAX_LOGICAL_DRIVES_40LD :
> +					     MAX_LOGICAL_DRIVES_8LD;
>  

Churn, if not readability loss. Note the indentation change here is 
inconsistent with the indentation change noted above.

>  			 * 6-byte READ(0x08) or WRITE(0x0A) cdb
>  			 */
> -			if( cmd->cmd_len == 6 ) {
> -				mbox->m_out.numsectors = (u32) cmd->cmnd[4];
> -				mbox->m_out.lba =
> -					((u32)cmd->cmnd[1] << 16) |
> -					((u32)cmd->cmnd[2] << 8) |
> -					(u32)cmd->cmnd[3];
> +			if (cmd->cmd_len == 6) {
> +				mbox->m_out.numsectors = (u32)cmd->cmnd[4];
> +				mbox->m_out.lba = ((u32)cmd->cmnd[1] << 16) |
> +						  ((u32)cmd->cmnd[2] << 8) |
> +						  (u32)cmd->cmnd[3];
>  
>  				mbox->m_out.lba &= 0x1FFFFF;
>  

Here, the orphaned term is moved up, next to the =. And yet,

>  
>  			/* Calculate Scatter-Gather info */
> -			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
> -					(u32 *)&mbox->m_out.xferaddr, &seg);
> +			mbox->m_out.numsgelements =
> +				mega_build_sglist(adapter, scb,
> +						  (u32 *)&mbox->m_out.xferaddr,
> +						  &seg);
>  
>  			return scb;
>  

... here the first term is moved down and orphaned, which is another 
inconsistency.
