Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047A14AF2CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiBINbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiBINb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:31:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065DC0613CA;
        Wed,  9 Feb 2022 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644413490; x=1675949490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dklkovralpaNZUCLIrh9F8Z9chSn7WxXn18fxH7CzIA=;
  b=WIlx8Ot5U9j4AP6gw3L2BqkiSWQR7jSfLO+muZBd4s9JSMFppSlGQCrg
   Nbf6OLqBAUwr6RQ+7U3EoZQfXIsKLWOC2pc7+v4QIVcaXDyV5nIJ8MhA+
   fqp7jtH86KBaMQ8jG5mYAZbxwujeCriXRqoE6MedO1zFDzv8wXUVGCUYS
   8FjjOBj8z6cgrz00F1QLfGUXVo7JuIz3ZNqfv2hdO1yZvEJYlVpi0OjG1
   0KE/tayBi75n6cbyOg5yoTSnf3aJP33Zc8wXkUxN1+vazr7aXtIWxrIED
   lwYbonfeHTiPAfr5ML19uKt4ocsw5Ub5C54KsAjiUErj04bTkuEKIwyyQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229850168"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229850168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:31:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678587108"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 05:31:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 15:31:26 +0200
Date:   Wed, 9 Feb 2022 15:31:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YgPCLopskwyQ6F4K@kuha.fi.intel.com>
References: <20220208091621.3680427-1-xji@analogixsemi.com>
 <20220208091621.3680427-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208091621.3680427-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:16:21PM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.

We already have the driver drivers/usb/typec/tcpm/tcpci.c for port
controllers.

If you need a glue layer - if there is something specific that you
need to do with ANX7411 that is not completely TCPC compliant - use
drivers/usb/typec/tcpm/tcpci_*.c as examples.

thanks,

-- 
heikki
