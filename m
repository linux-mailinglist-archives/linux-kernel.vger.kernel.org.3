Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D495246EF38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhLIRDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:03:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:58924 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241821AbhLIRD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639069196; x=1670605196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jb7CwzDxKXr/7UaWgRJtMnceItXgbQOBYj8g3WpneL0=;
  b=Bn93TAdXTexuKYe1Fjc6RjiMe8sAeOURkhwo2aESHN0MgSfas+4kxq9x
   HX7u1oWiNhWZ1z6SR1+jWBycvVAwKQE/22smFEpBW+Ir/R1lHYZgcOzWS
   lqxv2On0TIp/K8XzZ3Kq6v2TNuKgNua5IXSu8kS18P8HggYmfNQyJiVFD
   rBL2fCpXV7IHMSKSIF4KwFq2fcitHZzg9sYht0cmPxVSVT+bu2rxicsPK
   GTKtuP7m4y3DwRccc/Jya8wTPZGBjHAeoDFOmOsJtwP76AD027TO/2gO6
   hM7tGWV8DhKXURS2TSObrvcYkkXK6zk4dz60H3I3wz2Ht782GOQ+PBfpt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218175860"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="218175860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:59:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="503565784"
Received: from ayushshr-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.115.39])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:59:54 -0800
Date:   Thu, 9 Dec 2021 08:59:53 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove myself as modules maintainer
Message-ID: <20211209165953.wohokahzh5z6tnw7@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211209084313.10621-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211209084313.10621-1-jeyu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:43:13AM +0100, Jessica Yu wrote:
>Luis has done a great job maintaining modules so far. As I'm planning to
>take a break from work soon, I think we're ready to transition over fully.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>


Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>


Thanks for your work maintaining the modules! Agreed Luis is already
doing a great job, also sending patches for kmod userspace.

Lucas De Marchi
