Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC850872E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbiDTLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378187AbiDTLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:41:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1036441601;
        Wed, 20 Apr 2022 04:38:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A863F21115;
        Wed, 20 Apr 2022 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650454724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07ddCTy31iWqzu2w3ATEUEla6+CUZWFYjXLLhVU25JE=;
        b=NsEzrHym87dRqLZdHm9zjmy50aB2VETeUDmasiUdmVJRpWyP5115Oq/2VSMPRvdF4+9PP2
        mMGflypdKXHtTAk+X9MbvZA5o6XZ0+gLznmA90DTyudhybdQJhhpIXPc3ydgcncyXpaQ3a
        cTXE4JzMybSXV/Cvunq6Srwam+0FQxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650454724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07ddCTy31iWqzu2w3ATEUEla6+CUZWFYjXLLhVU25JE=;
        b=o2AOWv0G20CzzZ6G+WC6scUZZcFMrzJtB7EWcibiigLacAjwHkDFDOcAQwBcbYE1kOXNE7
        gxtJ15U32IhKrPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F28213A30;
        Wed, 20 Apr 2022 11:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yBfiIcTwX2K0TAAAMHmgww
        (envelope-from <mliska@suse.cz>); Wed, 20 Apr 2022 11:38:44 +0000
Message-ID: <2e8ea259-b77c-836a-2aea-d66eb47dd294@suse.cz>
Date:   Wed, 20 Apr 2022 13:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Add HAVE_DEBUGINFOD_SUPPORT to built-in features.
Content-Language: en-US
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     linux-perf-users@vger.kernel.org
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <0d1c5ace-88e8-7102-1565-7c143f01a966@suse.cz>
In-Reply-To: <0d1c5ace-88e8-7102-1565-7c143f01a966@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(removing gcc-patches ML that was accidentally included)

On 4/20/22 13:30, Martin Liška wrote:
> The change adds debuginfod to ./perf -vv:
> 
> ...
> debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
> ...
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>   tools/perf/builtin-version.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 9cd074a3d825..a71f491224da 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -65,6 +65,7 @@ static void library_status(void)
>   #endif
>       STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
>       STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
> +    STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>       STATUS(HAVE_LIBELF_SUPPORT, libelf);
>       STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>       STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);

