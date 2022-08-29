Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2925A51C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiH2QbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiH2QbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:31:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB2186C9;
        Mon, 29 Aug 2022 09:30:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB21A2E0;
        Mon, 29 Aug 2022 16:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB21A2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661790658; bh=6S2NvRoZE/Y8A50MoD1XPsNF4V8uUQaelVt/mreMJRg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gNwEAPj165YacmV5Ngo8DAVSTlVaXOD9wnwNCqaBU/YBdgftaev80ngRiYcR7ZyO6
         P/kSWojSF4TsBKmMDwxxbKuULBTGqUQvcLq0D1+AO9Vai9Zef5BstG2ytlTFgflGZm
         nhkdMFWbgIeMJ3YI0xfyAW5McHWc8uNDJd/BAOagr6p8KTrdT7S1R2uQBUehb3VR8Y
         2ELd2FW07UkVdNxrcVZ2B+Vv4gzsvn+3YBzgmiVGFfX1a+/j72jtbIP3jGepJ327R1
         11crHnaVQCMapwM5UpjnBFYN8g5cd9YCk41vXTYWBOCcKLd0ijp0riaY9slHt9VlHM
         JoZ5wacjNz2KA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] Remove duplicated words across the whole documentation
In-Reply-To: <20220826163458.1142-1-jmaselbas@kalray.eu>
References: <20220826143300.6794-1-jmaselbas@kalray.eu>
 <20220826163458.1142-1-jmaselbas@kalray.eu>
Date:   Mon, 29 Aug 2022 10:30:57 -0600
Message-ID: <87wnarovum.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules Maselbas <jmaselbas@kalray.eu> writes:

> Remove duplicated words (the, at, be ...) across the whole documentation.
> In some cases the duplicated words are replaced by something that makes
> more sense, for instance: "be be" is replaced by "can be" when possible.
>
> There are likely more duplicated words to be found.
>
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Bagas Sanjaya <bagasdotme@gmail.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: linux-doc@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
> in v3:
>  as suggested by Randy Dunlap:
>  - remove duplicated 'The the '
>  - remove duplicated 'at at ' (some are replaced by 'at a ')
>  - remove duplicated be, is, to, we, on ...
> in v2:
>  - also remove the second 'the' in one sentence as suggested by
>    Bagas Sanjaya
>
>  Documentation/RCU/checklist.rst                               | 2 +-
>  Documentation/admin-guide/kdump/vmcoreinfo.rst                | 2 +-
>  Documentation/admin-guide/media/vivid.rst                     | 2 +-
>  Documentation/bpf/instruction-set.rst                         | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst                      | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst                        | 3 +--
>  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml  | 4 ++--
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt      | 2 +-

When you redo the patch to reflect the other comments, please split the
devicetree changes into a separate patch.  I don't handle devicetree
stuff, so that will need to go via a separate path.

Thanks,

jon
