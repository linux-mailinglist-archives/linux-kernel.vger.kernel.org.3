Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A951055D8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiF1J4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiF1J4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:56:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C282ED7F;
        Tue, 28 Jun 2022 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656410136; x=1687946136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZySJLtccvViq3V6jqeioJpJY2xcTgx0ACUTORRR1JEg=;
  b=AKvhSZkADlFqUmDylhXcP7UmnnFPiOrtXsvsEeBHrT0GEATzDSXpf8Ln
   Vf6ArNgoQsz2ThLXYxRWe91wMHSeXyeur3EgJYLxe/WKf1BdB1Y9BvavP
   pTQOVuNT1EJVo50OlqHqcHDoVTRlNJ4LM+aL3xhxseuBixjWT5PN1vkAz
   OqS6aY3mST/V7477wY5kBDyXFbumPaPAbwKzSPvwFd3QxzWJzOK9NBnaO
   uSIl7VbHaUmbwSfYHOCxHFfvOothCvX7PtjkG/RE7vg+zxALywcPLSgTS
   INLqajweLkcTDLb3sTTRI7T95/KRKSxJh9a2sVUPj8fzb/GOJxh9QhBkH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343385713"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343385713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732690989"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2022 02:55:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jun 2022 12:55:29 +0300
Date:   Tue, 28 Jun 2022 12:55:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 20/22] usb: typec_altmode: add a missing "@" at a
 kernel-doc parameter
Message-ID: <YrrQES9cTnKhp+6h@kuha.fi.intel.com>
References: <cover.1656409369.git.mchehab@kernel.org>
 <70dc4c5d744cf1fe9a0efe6b85deaa0489628282.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70dc4c5d744cf1fe9a0efe6b85deaa0489628282.1656409369.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:46:24AM +0100, Mauro Carvalho Chehab wrote:
> Without that, the parameter is not properly parsed:
> 	include/linux/usb/typec_altmode.h:132: warning: Function parameter or member 'altmode' not described in 'typec_altmode_get_orientation'
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
> 
>  include/linux/usb/typec_altmode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 65933cbe9129..350d49012659 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -124,7 +124,7 @@ struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,
>  
>  /**
>   * typec_altmode_get_orientation - Get cable plug orientation
> - * altmode: Handle to the alternate mode
> + * @altmode: Handle to the alternate mode
>   */
>  static inline enum typec_orientation
>  typec_altmode_get_orientation(struct typec_altmode *altmode)
> -- 
> 2.36.1

-- 
heikki
