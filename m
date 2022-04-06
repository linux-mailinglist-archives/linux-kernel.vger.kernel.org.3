Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3F4F6A53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiDFTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiDFTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:49:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A64210447
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649270261; x=1680806261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vwP7tqcATHHZbPTdGKag4qVPI+s/ZhYdH5Hhb5WB3pI=;
  b=j+5OrFIiKUhF+fcNunzY4ArMaiuIa32lbz8thRQ4tT0YZr+q0bDWPagA
   c0Q9CiX2YPZixw1k4X47Kg85Cw6SpWaXsSVR+F2w0m0jQ0fb1eeCpwZ+9
   mgN4kX7Uj0RwcV3J+kqJ7Hwpgj7hgaVwckn5In/8Fb54eL0J2gFA2crAG
   Qc3C7ZKPdgTj885dwfvdGnk0DVHUeLEa+ab3ePExxI34nnqyLMzzBvttu
   4no6rlblGsv7DXZ2CFk/pWpAtdObIc3mRQZtaHVXFZ2uP3pZACjkdJwuf
   MVxR4oC/+e8Oa+bI7jgQ+Vpp7Q225dwTkErrL0DRlzALRJ2EBQlX5TjsO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321822244"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="321822244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:37:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="588483890"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.19.90]) ([10.212.19.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 11:37:40 -0700
Message-ID: <b19466ad-afae-7c70-cd28-73e3959c48f4@intel.com>
Date:   Wed, 6 Apr 2022 11:37:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] staging: r8188eu: correct misspelling in comment
 'tppe' -> 'type'
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1649233201.git.remckee0@gmail.com>
 <edaab7d38893e4f1cbb3c281b617c74fa91f0fe7.1649233201.git.remckee0@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <edaab7d38893e4f1cbb3c281b617c74fa91f0fe7.1649233201.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 1:30 AM, Rebecca Mckeever wrote:
> Correct spelling typo.
>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index cd20811ae152..f4a277e6b654 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1162,7 +1162,7 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>   	}
>   
>   	pdrvextra_cmd_parm->ec_id = P2P_PROTO_WK_CID;
> -	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command tppe. */
> +	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command type. */

Nothing to do with this patch. Just saw intCmdType. Suggest another 
patch to fix this mixed case function parameter. Maybe cmd_type instead?


>   	pdrvextra_cmd_parm->pbuf = NULL;		/*	Must be NULL here */
>   
>   	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
