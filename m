Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09384DC4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiCQLow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCQLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:44:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFC56773;
        Thu, 17 Mar 2022 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647517415; x=1679053415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izMyFSd/6/exTcmhx8kxg+WRK3vb/oe1G6XfehxbOcw=;
  b=bamGKhWgR22flfkrNChcQ9UNGjblXG8A4DjIUq2qRnkAlIzLUVXtT5Wg
   aqgz/zzyV8Me+aag4xKN4PQb7hmTr/gHcKvQsgLInh+qRXY/xNM1uQfs/
   qZY+Mib8TRmOx23hs9MCMqivXK9ia7ZvvrX435uXa6nku/92E1D94qTw1
   Iq6AtF4p3aKwNkZMyxFDDkJAMor8FzFiRZFVYI49n7Nn2g6IQ3C6aGvRg
   BoYlziYSY5uL+Ld3tHnV2HiQFp9Z/PbUQpfKjbQpAeRc0SFDlC514uQBo
   xd9DB4UhEHPOXae36sK9w4To4EfH9LxM2FQ9rgf+T45reWrsWEKF16NPY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254402656"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254402656"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 04:43:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="513397834"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 04:43:31 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 13:43:29 +0200
Date:   Thu, 17 Mar 2022 13:43:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 0/2] ACPI: bus: Fix platform-level _OSC handling and
 avoid CPPC is not supported
Message-ID: <YjMe4Wdh6Y8PkVE5@lahna>
References: <4734682.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4734682.31r3eYUQgx@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Mar 16, 2022 at 01:35:23PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> The following two patches revert a commit that caused the handling of
> platform-level _OSC to fail in some legitimate cases and address the
> CPPC handling breakage that was the motivation for the reverted commit.
> 
> Please refer to the patch changelogs for details.

For both,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
