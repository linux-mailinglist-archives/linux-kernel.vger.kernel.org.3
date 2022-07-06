Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB886568EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiGFQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiGFQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:10:13 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92471E3C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:10:12 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5060420FD;
        Wed,  6 Jul 2022 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657123749;
        bh=3YGmqJNC0z7ScYj2kVJNbbiNALnLk+mxn85TugXCSlA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u1epzL3nN66SkYQHBd4EtdtJfXIMoqWNbKvtkgcgrExwj2q4qrSfjIcjPZ2A/3LWM
         ON1zVOsAyV90JWfJbadrYJE/JhzPBOSIDczCdpyS47/u3L9QlE0T7vWimhZRnCxRRR
         zpWYux0ywl7T/JiAp/+7WCLkq2Bn2zJfB82GW5Ys=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F1680455;
        Wed,  6 Jul 2022 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657123810;
        bh=3YGmqJNC0z7ScYj2kVJNbbiNALnLk+mxn85TugXCSlA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mfpEIpZz5ZxE3WG/P96wN4o/7POQNRlQKL5cBudOqvddgThhADHL8nJluTiQFv2sM
         fuK2VkaqtfiQSoqi3qjlnBsA+6oAWuDnza2K5Yvk9z+nUVBXGyDi99qfaWe7TI7Y39
         lubxFlVyRVqGEoI6JAFUpYecTwObg8DXnbsQkgPw=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Jul 2022 19:10:10 +0300
Message-ID: <7a1f5139-fe5d-2b9b-7738-d2283599cdfb@paragon-software.com>
Date:   Wed, 6 Jul 2022 19:10:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3/indx: Remove unnecessary 'NULL' values from
 Pointer
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20220704103113.5529-1-kunyu@nfschina.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220704103113.5529-1-kunyu@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 13:31, Li kunyu wrote:
> Pointer variables allocate memory first, and then judge. There is no
> need to initialize the assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   fs/ntfs3/index.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6f81e3a49abf..b5c92b6ce01c 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1685,8 +1685,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
>   {
>   	int err;
>   	const struct NTFS_DE *sp;
> -	struct NTFS_DE *e, *de_t, *up_e = NULL;
> -	struct indx_node *n2 = NULL;
> +	struct NTFS_DE *e, *de_t, *up_e;
> +	struct indx_node *n2;
>   	struct indx_node *n1 = fnd->nodes[level];
>   	struct INDEX_HDR *hdr1 = &n1->index->ihdr;
>   	struct INDEX_HDR *hdr2;

Thanks for patch, applied!
