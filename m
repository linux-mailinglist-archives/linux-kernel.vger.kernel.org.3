Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC351EF38
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiEHTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiEHRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:36:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F0E01D;
        Sun,  8 May 2022 10:32:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so7112161wmz.0;
        Sun, 08 May 2022 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xtzshtqnY57AWyG48xUrSZO3HB2YKLPUbkukb3SwPVQ=;
        b=M82/1R7PVx4QETpQp8jd5Dpvdy43cfwQey7aKxG1Oee6G0fdxUFZ/SFrcagPRRfRAU
         i5tj3yATsxyXaOaYeOLEKaFKGDYndRGt2b76XzdOPP6QGIb/EiZl32lpNJNrMK12l2/O
         cTWkYH0HL8fcr4mdnGzG+Y5i0y5SFZLiTmJsGtLndn/3SpRt7HfNMobP0wi6Bne6VJvF
         S6VxawGEzS6pp0RrAEbS26XEHbDa3VP0yNn/S8FZSioHk0cl7z5uZ/c7HfNntCHbd67L
         voI5Ex0vlYt7XG1q+EUtYmSy2OSnEuLNA6hYsAuab3O8ds7B4xtqZgoF8MAsYlfN01dj
         RvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xtzshtqnY57AWyG48xUrSZO3HB2YKLPUbkukb3SwPVQ=;
        b=QB3iZkuRZkso/pkDxGpqI3oka3uYE+KZWfkISDm3kuAF3J+AXouZl32qTOmD0xeDGK
         aVnSGJ+ZdCL+zjT/IxGFh1BWfTXirYbmIZ26ow2Tj4OAXhY0Rl4B2/HS4BKAMM9ceBEU
         8DGYyqInx5wFkkTZ3DYxKq3/T+4jwiXV0gzbUp0aLnJzwAxW/UA4PfIWqmfSFkt4mNWP
         QJh5/xdttvCl0bPlpVe4JBcqIqySGYPPP1YBoLBzWYnD4ARFIKnG/dO71ZGpgm52Nl+l
         7lKN5ZOjvtXHXXsKcE90k7ipIq0HSEGKX4Qd1M3+BkNDG036s4EyKhzFDf2GczRjMOf8
         xY0w==
X-Gm-Message-State: AOAM531adI4LKL8snjbvBfwUI3c7ifwKEXdjOW/rnYqMJ8+/R2pzofkJ
        MhoA+zXZWmobRkqiPUb1t9s=
X-Google-Smtp-Source: ABdhPJxQ9JqWkArKi3om7Wq/rZFQSDPiyvqplr6k71x0dsq7vxjakAcQeRYsU9etIK3UmV0wBb6bOw==
X-Received: by 2002:a05:600c:4808:b0:393:fbd3:f1fa with SMTP id i8-20020a05600c480800b00393fbd3f1famr19282520wmo.100.1652031132512;
        Sun, 08 May 2022 10:32:12 -0700 (PDT)
Received: from elementary ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d464c000000b0020c5253d90esm10303182wrs.90.2022.05.08.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 10:32:12 -0700 (PDT)
Date:   Sun, 8 May 2022 19:32:05 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     jikos@kernel.org, kbuild-all@lists.01.org,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com
Subject: Re: [PATCH for-5.19/uclogic 1/7] HID: uclogic: Move param printing
 to a function
Message-ID: <20220508173205.GA34347@elementary>
References: <20220508160146.13004-2-jose.exposito89@gmail.com>
 <202205090129.trznWqE6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202205090129.trznWqE6-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 01:16:28AM +0800, kernel test robot wrote:
> Hi "José,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on hid/for-next]
> [cannot apply to v5.18-rc5 next-20220506]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

Missing --base=<commit> argument, the patch applies without issues on
for-5.19/uclogic.

Let me now if you need me to resend it,
Jose



> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/DIGImend-patches-part-VI/20220509-000510
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220509/202205090129.trznWqE6-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/4c0671e4ce0687136ff71aa65539cd3a2798d99d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jos-Exp-sito/DIGImend-patches-part-VI/20220509-000510
>         git checkout 4c0671e4ce0687136ff71aa65539cd3a2798d99d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/hid/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/hid/hid-uclogic-params.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
>    drivers/hid/hid-uclogic-params.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Dump tablet interface frame parameters with hid_dbg(), indented with two
>    drivers/hid/hid-uclogic-params.c:105: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Dump tablet interface parameters with hid_dbg().
> 
> 
> vim +48 drivers/hid/hid-uclogic-params.c
> 
>     46	
>     47	/**
>   > 48	 * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
>     49	 *
>     50	 * @hdev:	The HID device the pen parameters describe.
>     51	 * @pen:	The pen parameters to dump.
>     52	 */
>     53	static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
>     54						const struct uclogic_params_pen *pen)
>     55	{
>     56		size_t i;
>     57	
>     58		hid_dbg(hdev, "\t.usage_invalid = %s\n",
>     59			(pen->usage_invalid ? "true" : "false"));
>     60		hid_dbg(hdev, "\t.desc_ptr = %p\n", pen->desc_ptr);
>     61		hid_dbg(hdev, "\t.desc_size = %u\n", pen->desc_size);
>     62		hid_dbg(hdev, "\t.id = %u\n", pen->id);
>     63		hid_dbg(hdev, "\t.subreport_list = {\n");
>     64		for (i = 0; i < ARRAY_SIZE(pen->subreport_list); i++) {
>     65			hid_dbg(hdev, "\t\t{0x%02hhx, %hhu}%s\n",
>     66				pen->subreport_list[i].value,
>     67				pen->subreport_list[i].id,
>     68				i < (ARRAY_SIZE(pen->subreport_list) - 1) ? "," : "");
>     69		}
>     70		hid_dbg(hdev, "\t}\n");
>     71		hid_dbg(hdev, "\t.inrange = %s\n",
>     72			uclogic_params_pen_inrange_to_str(pen->inrange));
>     73		hid_dbg(hdev, "\t.fragmented_hires = %s\n",
>     74			(pen->fragmented_hires ? "true" : "false"));
>     75		hid_dbg(hdev, "\t.tilt_y_flipped = %s\n",
>     76			(pen->tilt_y_flipped ? "true" : "false"));
>     77	}
>     78	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
