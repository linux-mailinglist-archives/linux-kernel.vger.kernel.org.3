Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF2559752
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiFXKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiFXKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:05:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B0E4E3B7;
        Fri, 24 Jun 2022 03:05:49 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25OA5QLd099780;
        Fri, 24 Jun 2022 19:05:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 24 Jun 2022 19:05:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25OA5Q1V099777
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Jun 2022 19:05:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f754e6cd-8f99-a42e-9b65-3f4971e51432@I-love.SAKURA.ne.jp>
Date:   Fri, 24 Jun 2022 19:05:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] tomoyo: Fix typo in comment
Content-Language: en-US
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, takedakn@nttdata.co.jp
References: <20220624070254.33998-1-wangxiang@cdjrlc.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220624070254.33998-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for a patch, but current is correct. ("path2" means takes two path arguments)

On 2022/06/24 16:02, Xiang wangx wrote:
> Delete the redundant word 'path'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  security/tomoyo/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
> index 1e6077568fde..772f7e1ddf6e 100644
> --- a/security/tomoyo/file.c
> +++ b/security/tomoyo/file.c
> @@ -286,7 +286,7 @@ static bool tomoyo_check_path_number_acl(struct tomoyo_request_info *r,
>  }
>  
>  /**
> - * tomoyo_check_path2_acl - Check permission for path path operation.
> + * tomoyo_check_path2_acl - Check permission for path operation.
>   *
>   * @r:   Pointer to "struct tomoyo_request_info".
>   * @ptr: Pointer to "struct tomoyo_acl_info".
