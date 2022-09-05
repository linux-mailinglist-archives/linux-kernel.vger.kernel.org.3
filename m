Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D75ACDA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiIEIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiIEIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:30:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC14F652;
        Mon,  5 Sep 2022 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662366506; x=1693902506;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DLTuQGZ9IZSga0Dpa9lI7WYVAW6V0NwfP+YcJ2Yf+P0=;
  b=FElm3Tv6JNzuk1PV5mVuYKI9hNE7RQe+vVU0bmAX8XnDCn5R4BEaC4zM
   xPNp2LZ0hFRogrVlqBRmmc6TcJlmdUNWajqmXZfV185gNcCCH2op8NkLG
   5zTnPhzs2drb53kad0ATdSymSoj8s3MxBksOJzBB9aKKuTagZ1yjNYNq0
   TEIQJ42c9jNOQXLF04yMdZXeHM3ve733JBR7mFpR6g7yQeGeYYTQAFtNU
   m2b7S2QenGOxb0BiRDkxmAMo8egha73NVOtkVthp3FU+kLnkNxkry+djB
   TnETEGul0nPM12rffFslz77ctP9wcFr9TW8/8MoPuedR/BniAeIO5XQWE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276732615"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="276732615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:28:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="675191211"
Received: from smaciag-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.57.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:28:24 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/4] docs: Rewrite the front page
In-Reply-To: <20220901231632.518583-3-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220901231632.518583-1-corbet@lwn.net>
 <20220901231632.518583-3-corbet@lwn.net>
Date:   Mon, 05 Sep 2022 11:28:08 +0300
Message-ID: <8735d6cjjb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Sep 2022, Jonathan Corbet <corbet@lwn.net> wrote:
> The front page is the entry point to the documentation, especially for
> people who read it online.  It's a big mess of everything we could think =
to
> toss into it.  Rewrite the page with an eye toward simplicity and making =
it
> easy for readers to get going toward what they really want to find.
>
> This is only a beginning, but it makes our docs more approachable than
> before.

\o/

> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-a=
pis.rst
> new file mode 100644
> index 000000000000..f5d8bcc023c8
> --- /dev/null
> +++ b/Documentation/subsystem-apis.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Kernel subsystem API documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

How about making this "Kernel subsystem documentation"?

For example the GPU documentation is so much more than just API
documentation. And the paragraph below is more generic too, "how
specific subsystems work".

BR,
Jani.

> +These books get into the details of how specific kernel subsystems work
> +from the point of view of a kernel developer.  Much of the information h=
ere
> +is taken directly from the kernel source, with supplemental material add=
ed
> +as needed (or at least as we managed to add it =E2=80=94 probably *not* =
all that is
> +needed).

--=20
Jani Nikula, Intel Open Source Graphics Center
