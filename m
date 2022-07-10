Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6C56D0BA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGJSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:25:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875F13D1C;
        Sun, 10 Jul 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657477526; x=1689013526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6aFXrMG+va2IZjOmp0OkSsM4/LOorOUIHVe5fbwzo7g=;
  b=eRZsrTin40xOegmwDtY3wM0qUcCykxiJKdu0qbTPWjgW3GoNYKlI7Zh0
   M/WywLMdVNa6wxYVcqJdrLA+uohjEFDHKIO0QlAEYCH8Dk4tP3H5fYF4U
   XPKZtApFjDfvXnAjn088/Wk6ctnL3+/h9UAc97vaxj0bASxj7hvIIHkZI
   lUi4VKUPtgfpLK80BuzUxlZlIKTmCJRMkxWIQqPhfL+8k4OXUqFO3ok2Y
   vmKSkikYPjS50b9oph4scy1VaNa5R8ooHlwMtVQIf/VC04gvv+KbwgWMz
   Zkk9XuSDvrkO18eUg+R6XPrJiKzSd/Bf8Yrq19Uu1dywi+WTReNTZ2uH7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282081436"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282081436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="736864827"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:25 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/2] Two fixes for IFS
Date:   Sun, 10 Jul 2022 11:25:19 -0700
Message-Id: <20220710182521.60642-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
References: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans ... if you are pushing to Linus to add "BROKEN", then could
you include these two patches to make it fractionally less broken?

-Tony

Jithu Joseph (2):
  Documentation: Correct IFS reload documentation
  platform/x86/intel/ifs: return error on load failure

 drivers/platform/x86/intel/ifs/ifs.h  | 2 +-
 drivers/platform/x86/intel/ifs/load.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.35.3

