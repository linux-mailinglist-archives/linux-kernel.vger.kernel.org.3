Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B24FFB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiDMQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiDMQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:44:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80760674E2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:41:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 125so2281852pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U0mYbeDxiP5fHUbrg4sKbHdXRde2/HGpSIrFIzyQPyY=;
        b=mOkQZp4B9v+XiUJyjo6qJzUPdPuVRegkA5c31EeT93Vjn4N+jtRG0TpVRQRbEDkQR8
         Ev0pKTeaBfXvKKuffvCAsHJQC8FOsGbAK3TvZquX8uQ4TSSax1VS/ZXE1/yijKXvdfyo
         8V+okUq7jGM5tnLmkPqE4DQYPEchgh4x4wG80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U0mYbeDxiP5fHUbrg4sKbHdXRde2/HGpSIrFIzyQPyY=;
        b=yx1Me5nDinPBSq/cg+ZQkqE+BzHuWGClmfWUV6rmmZVhPMGKMxv5kzDm8mm2QpX5dB
         I8SLeH0OcSoIBG6wqvvy1kyq2Z5zzXNhMCsdo8XL0k0VC9SoV1aJTeP6Y+B/YG43fYgx
         0bPrJymHHGjL3zKM41fbhTOqVL6HCNjvNmZtQYJf23T+/a4g/wk9n75gv6zaYPq0r1cB
         NQHzL3Ld7IcILR7gyh3P0hzW33waKvxnCCJ7n/wm9fvkLV2FcoaY/KexEXOiAVAWkbHB
         yPPYr+vQQ+Dj0A8mo/edrPe48ZplNMyUgptuyoQqUUvotaF7ZxOhykS/yoY8Cpi3okdg
         qfXg==
X-Gm-Message-State: AOAM531L/W7A0BAmeJWArJOKF1P8KVudNs9aPUAreC87836sM17SZXlV
        sKd/LBd81++qwIM/20OUzxiAzUGQ4bTl4g==
X-Google-Smtp-Source: ABdhPJxwzzFHl0F7a53iggWl2r6N+6mTqaFE64Ha6gudvaBnmGCDEvrtLjcahaXz4Ga08iENIgqL1w==
X-Received: by 2002:a63:b66:0:b0:39c:ef72:bb70 with SMTP id a38-20020a630b66000000b0039cef72bb70mr24072892pgl.354.1649868103895;
        Wed, 13 Apr 2022 09:41:43 -0700 (PDT)
Received: from fastly.com ([198.233.245.70])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a029700b001cbaff492f2sm3511394pja.30.2022.04.13.09.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:41:43 -0700 (PDT)
Date:   Wed, 13 Apr 2022 09:41:41 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tnguy-next-queue:dev-queue 235/256]
 drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of
 'protocol' with no linkage
Message-ID: <20220413164140.GA9392@fastly.com>
References: <202204140015.MRcE3hbT-lkp@intel.com>
 <bcdfdf24-bd8c-f487-5a26-88ee0b1bdb43@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdfdf24-bd8c-f487-5a26-88ee0b1bdb43@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:40:24AM -0700, Tony Nguyen wrote:
> 
> On 4/13/2022 9:35 AM, kernel test robot wrote:
> >tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
> >head:   faadd15618a12d7b11208f11c54d6ac0f2776486
> >commit: 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc [235/256] ice: Add mpls+tso support
> >config: powerpc-buildonly-randconfig-r003-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140015.MRcE3hbT-lkp@intel.com/config)
> >compiler: powerpc-linux-gcc (GCC) 11.2.0
> >reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
> >         git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> >         git fetch --no-tags tnguy-next-queue dev-queue
> >         git checkout 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/intel/ice/
> >
> >If you fix the issue, kindly add following tag as appropriate
> >Reported-by: kernel test robot <lkp@intel.com>
> >
> >All errors (new ones prefixed by >>):
> >
> >    drivers/net/ethernet/intel/ice/ice_txrx.c: In function 'ice_tso':
> >>>drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of 'protocol' with no linkage
> 
> Hi Joe,
> 
> You can ignore this, this was a mistake on my part and I've fixed it.

No worries; thanks for letting me know.

Thanks,
Joe
