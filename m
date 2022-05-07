Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5075551E47D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445700AbiEGFqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377055AbiEGFqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:46:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DE58385
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:42:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p6so8784894plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axGutF4EXG2joxqSIRJRWv9W9uFIDQlZyIhhoP3wHfI=;
        b=QAziMRhwsaLQWo1ymC0YlxrEcOJaap42j2MiqetYaNZHEZ+GDSbSYLdwriPafFxtZW
         S9uhAOupouNSohNtCKbz7oArvyjgsEwO8AjpyHBaQZLBng8/TlIdBWZ7Gj7CfVCY/Zb9
         0hTlcjWjepG5L0d5QCcYDRxp3jt6/8oVgrxy7n4v8hNRWDxM5E0t3XE5/13qva5KABth
         6niWq+BmUionAqzWhkd7167d0r//7krFGBZtr/gUyD358hNWM/Mbs+yj9prtoFAOOkdm
         t0rDhW3dlJ0w9MpHVO7agTXTY1KEzjl1T6j2CvEumDquzNELLksQ0KeXaqu40dMyi/qv
         inwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axGutF4EXG2joxqSIRJRWv9W9uFIDQlZyIhhoP3wHfI=;
        b=mqltDC1FBwKTN/iadtSmbVhfvfjCzprgiWrvwBFRFOnZQJnqKaOydxEw0jXi6QXLul
         7gQeocSU+mym950lDnbM1hQSLZ6BhAOEmDOJXpUUMZlmAbn/SpgRwIfQX/deVyoUAlCh
         UGt0WUTOGBPrJjkQS8odVRKBUJ3BPUZlR6Wc6UDtvoXzzc3EOSKraI1440kbDLhSCmmK
         4Jh+bjNY96k6blGSVkBrH00TmsXam9i+GMbKgF6sPgXlUTrHo28571K5c7/UhMbQ4qPf
         wz9k3XahcqnaYDe3PUXODDz0rlNkk75Ik2MmBWdM+HgpC81Zi4hBTjoaHGMkgv8nbetu
         PYPw==
X-Gm-Message-State: AOAM532PPeD1zNUFW/KSM6WDKb6YGSYoC4WrfDzUxq2d1hzoFpqKRThN
        UjuoOQbDnbmo8Z4ceF/UFuk=
X-Google-Smtp-Source: ABdhPJxtGSWhZZP1tgaKGZ3USdjTfC9nC6Jx0S823PC12IGb1Cp/8S7easenBRdpNWIT38SmkUHvqg==
X-Received: by 2002:a17:903:189:b0:15e:9584:fbe7 with SMTP id z9-20020a170903018900b0015e9584fbe7mr7391369plg.65.1651902166855;
        Fri, 06 May 2022 22:42:46 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902a70900b0015e8d4eb2absm2660503plq.245.2022.05.06.22.42.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 May 2022 22:42:46 -0700 (PDT)
Date:   Sat, 7 May 2022 13:42:47 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 3/3] erofs: refine on-disk definition comments
Message-ID: <20220507134247.00007786.zbestahu@gmail.com>
In-Reply-To: <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
        <20220506194612.117120-3-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 May 2022 03:46:12 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Fix some outdated comments and typos, hopefully helpful.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 1238ca104f09..000fa2738974 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -79,15 +79,15 @@ struct erofs_super_block {
>  
>  /*
>   * erofs inode datalayout (i_format in on-disk inode):
> - * 0 - inode plain without inline data A:
> + * 0 - uncompressed flat inode without tail-packing inline data:
>   * inode, [xattrs], ... | ... | no-holed data
> - * 1 - inode VLE compression B (legacy):
> - * inode, [xattrs], extents ... | ...
> - * 2 - inode plain with inline data C:
> - * inode, [xattrs], last_inline_data, ... | ... | no-holed data
> - * 3 - inode compression D:
> + * 1 - compressed inode with non-compact indexes:
> + * inode, [xattrs], [map_header], extents ... | ...
> + * 2 - uncompressed flat inode with tail-packing inline data:
> + * inode, [xattrs], tailpacking data, ... | ... | no-holed data
> + * 3 - compressed inode with compact indexes:
>   * inode, [xattrs], map_header, extents ... | ...
> - * 4 - inode chunk-based E:
> + * 4 - chunk-based inode with (optional) multi-device support:
>   * inode, [xattrs], chunk indexes ... | ...
>   * 5~7 - reserved
>   */
> @@ -106,7 +106,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
>  		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
>  }
>  
> -/* bit definitions of inode i_advise */
> +/* bit definitions of inode i_format */
>  #define EROFS_I_VERSION_BITS            1
>  #define EROFS_I_DATALAYOUT_BITS         3
>  
> @@ -140,8 +140,9 @@ struct erofs_inode_compact {
>  	__le32 i_size;
>  	__le32 i_reserved;
>  	union {
> -		/* file total compressed blocks for data mapping 1 */
> +		/* total compressed blocks for compressed inodes */
>  		__le32 compressed_blocks;
> +		/* block address for uncompressed flat inodes */
>  		__le32 raw_blkaddr;
>  
>  		/* for device files, used to indicate old/new device # */
> @@ -156,9 +157,9 @@ struct erofs_inode_compact {
>  	__le32 i_reserved2;
>  };
>  
> -/* 32 bytes on-disk inode */
> +/* 32-byte on-disk inode */
>  #define EROFS_INODE_LAYOUT_COMPACT	0
> -/* 64 bytes on-disk inode */
> +/* 64-byte on-disk inode */
>  #define EROFS_INODE_LAYOUT_EXTENDED	1
>  
>  /* 64-byte complete form of an ondisk inode */
> @@ -171,8 +172,9 @@ struct erofs_inode_extended {
>  	__le16 i_reserved;
>  	__le64 i_size;
>  	union {
> -		/* file total compressed blocks for data mapping 1 */
> +		/* total compressed blocks for compressed inodes */
>  		__le32 compressed_blocks;
> +		/* block address for uncompressed flat inodes */
>  		__le32 raw_blkaddr;
>  
>  		/* for device files, used to indicate old/new device # */
> @@ -365,17 +367,16 @@ enum {
>  
>  struct z_erofs_vle_decompressed_index {
>  	__le16 di_advise;
> -	/* where to decompress in the head cluster */
> +	/* where to decompress in the head lcluster */
>  	__le16 di_clusterofs;
>  
>  	union {
> -		/* for the head cluster */
> +		/* for the HEAD lclusters */
>  		__le32 blkaddr;
>  		/*
> -		 * for the rest clusters
> -		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
> -		 * [0] - pointing to the head cluster
> -		 * [1] - pointing to the tail cluster
> +		 * for the NONHEAD lclusters
> +		 * [0] - distance to its HEAD lcluster
> +		 * [1] - distance to the next HEAD lcluster
>  		 */
>  		__le16 delta[2];
>  	} di_u;

Reviewed-by: Yue Hu <huyue2@coolpad.com>
