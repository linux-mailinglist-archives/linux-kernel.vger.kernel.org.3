Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1F46E828
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhLIML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhLIMLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:11:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634EC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:08:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l25so18776925eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meMHjQXYwzr8UEaTie7G8n4pM7GBCdzDBli4kxnb0Tg=;
        b=OOL+ElmlZGkNF9l6UIuAjPRSkANUSqCooVBdrdK/IT+RLuQgbxfg/HCZrHQGheqKGb
         thyL511LPVXx90WTEXCWpmzdYzYktpqdbFnOgpmwkHb4Ej7CqQ5R6ii+isRTpejZj5gl
         WFNCjePwLrlDAMH3xmcE5GYVm3DtR/9X08uIbTukgTx6Jt0O3vOoo+Q+1GCQp1XxIRei
         urWQ0EQzu2ZOE+fTsu7817rOwGDX306xG3eFQdQY+GkHiLBj35B5tsjrKjp4mbBC60MN
         HnEHdLaVx5jLJtCcQvBPNcvSEHkXIZKVGdKboc6h9tIxwzQ3tobICblLP7SsdpvEJhCy
         0KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meMHjQXYwzr8UEaTie7G8n4pM7GBCdzDBli4kxnb0Tg=;
        b=74U9SjBcAZSlfu3sorKefDGXeSI0Vha+/99FHiaWGQLbBANX1d4DHU+3UGPv2sPhM/
         oxv83SvxHHaBkZdwomNy6cb9VZ7IJTuaoa9dOVsiB06EBvhCAc5749sy+l16UpHPgDzw
         pV7yXvwWgnSDODwDm6wQEllyV7ds4kJWkNZUbcP6kHUYpRBUpkxAP3UHgEAhlTc6hEbf
         0AjBjIS6D9OSahqVk5wO9/vfFGaSjjzRYQHsVuMZgTfo0pxIVlDQDfwcq444GP6M3Zzs
         AnXsttROMq5EL0649OjCakeaJuU7obgLf9yfg5kGfNZzs5b9Ls2sw6qdWjLEn0ozUjl/
         HX3A==
X-Gm-Message-State: AOAM530pbGcytrlInfmr631qfS7X4BdluHB5RIGrxe/ndBavDE9cqlfV
        /J/FI4dr8ekryh1qdQvDVErUb3es0KVOrFWOODMV81tzUIJhew==
X-Google-Smtp-Source: ABdhPJzmVoFexMTHbuzc5bZX8n+N/oKlt/fhNlpgiA/uSQFpUzX0k6P5eGYlTM+uD2GeExXLnsoNOXFkBk1KX0EgpY8=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr14693911ejb.69.1639051696813;
 Thu, 09 Dec 2021 04:08:16 -0800 (PST)
MIME-Version: 1.0
References: <202112091014.OAV9O2tr-lkp@intel.com>
In-Reply-To: <202112091014.OAV9O2tr-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Dec 2021 14:06:44 +0200
Message-ID: <CAHp75Vde4to079cN6Q71AENnGopSFfYYpBNPDsxbXK1sHw_C3A@mail.gmail.com>
Subject: Re: [hare-scsi-devel:ata-trace.v3 13/73] drivers/ata/sata_dwc_460ex.c:744:26:
 error: implicit declaration of function 'get_dma_dir_descript'; did you mean 'get_prot_descript'?
To:     kernel test robot <lkp@intel.com>
Cc:     Hannes Reinecke <hare@suse.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 6:36 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git ata-trace.v3
> head:   d973dee7af0328b9176e4a1710fb73093c334698
> commit: a8252508eadb132c62be4596a50701e1f261e92d [13/73] sata_dwc_460ex: use generic tracepoints
> config: arm-buildonly-randconfig-r005-20211207 (https://download.01.org/0day-ci/archive/20211209/202112091014.OAV9O2tr-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=a8252508eadb132c62be4596a50701e1f261e92d
>         git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
>         git fetch --no-tags hare-scsi-devel ata-trace.v3
>         git checkout a8252508eadb132c62be4596a50701e1f261e92d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/ata/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I believe this is related to
https://lore.kernel.org/linux-ide/20211208163255.114660-14-hare@suse.de/
logging rework.
Either way I'm fully in support of tracepoints instead of dev_dbg()
here and there.

-- 
With Best Regards,
Andy Shevchenko
