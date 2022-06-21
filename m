Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606BC5534BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiFUOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFUOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:42:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903324F06;
        Tue, 21 Jun 2022 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655822562; x=1687358562;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3cg98MSDxZXcoUuPDHI2nmcKFNOBrxiekk6k9TpI1Y=;
  b=HxFtPX8895GcGFkS5xzrNPivc3Uvq6ZUz8SA60ggAkqr1nFxvIf1akLb
   paSSLoxqXHdKyu2vfadE9NTepT/tlBX3QD+Omf9TNWSOwqXJotDkh+91h
   WbFRLgGHvrBHbzjf8Rzla4EEGUYuOM2YJJ7Jwxcp1z3QhwBVrUH9qjjM0
   uIpb59/jqQYtprn1JNYQsjyrmPSyX/XG23nq6rgaA3SnchPLUxRBJpyhj
   uaiz1YeZqRUrvj4hYh6ZbOmqij7uupRoZj5+Ba57S7jB+rZUglZG/Bv+I
   A4B0F28/FPX7glsOaeZuOSD91CHo8NOIQachPXWKUhyHqlFIbngjiN788
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341817714"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341817714"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:42:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="585773611"
Received: from johnkeat-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.188.142])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:42:25 -0700
Message-ID: <22649214925c2940bb524fd33d1f6ffc23223990.camel@linux.intel.com>
Subject: Re: [PATCH] ID: intel-ish-hid: hid-client: drop unexpected word
 "the" in the comments
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 07:42:21 -0700
In-Reply-To: <20220621122751.117143-1-jiangjian@cdjrlc.com>
References: <20220621122751.117143-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-21 at 20:27 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be
> dropped
> 
> file: drivers/hid/intel-ish-hid/ishtp-hid-client.c
> line: 331
>  * @device: Pointer to the the ishtp client device for which this
> message
> changed to
>  * @device: Pointer to the ishtp client device for which this message
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 4338c9b68a43..e3d70c5460e9 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -328,7 +328,7 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
>  
>  /**
>   * ish_cl_event_cb() - bus driver callback for incoming
> message/packet
> - * @device:    Pointer to the the ishtp client device for which this
> message
> + * @device:    Pointer to the ishtp client device for which this
> message
>   *             is targeted
>   *
>   * Remove the packet from the list and process the message by
> calling

