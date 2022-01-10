Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7348A287
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbiAJWNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:13:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:50230 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242582AbiAJWNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641852812; x=1673388812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paeOMBQ+PFO4xRISIaC7JHpDxbUxVGrbhnld7XD/pKk=;
  b=UwbmAnPrhv+dJ6rFLfuNvXFdsFtci/PdVTJjVe7yslHn5KrF5UnsS8/G
   c6yVtxkjKqpEYB7fKil3TUIsT3lf5Vk35IwgfkYIt/m2tiSaVIrSKQa/N
   5G8lBMXUklqTNsy3flqMooH9B93v3qekGRQsMd/VJ2HlszgyP4kRdJ2Ie
   ROxyQqySVlBxOGgKRimxn5PZM+t+tWoxp0mKpQOTLGyCRzcE0hjG8Sdhz
   z2P/uTmYHa/FYEjHgCRkPbFvvv1P+uv3GftCg2GkobY4H/ywMSgUMrLm0
   ssLL7gdPBffCX/N4Rm3NlfvC0ZIo24nlSE82Jh6kH2iz5wZGdSriY/d6Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="329682395"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="329682395"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:13:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="514841034"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:13:20 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 65B9D2043C;
        Tue, 11 Jan 2022 00:13:18 +0200 (EET)
Date:   Tue, 11 Jan 2022 00:13:18 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <YdyvfgNBHhhKZbTx@paasikivi.fi.intel.com>
References: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:55:58PM +0200, Andy Shevchenko wrote:
> The literals "big-endian" and "little-endian" may be potentially
> occurred in other places. Dropping space allows compiler to
> "compress" them by using only a single copy.
> 
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
