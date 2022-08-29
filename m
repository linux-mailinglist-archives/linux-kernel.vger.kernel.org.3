Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A995A462C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiH2JeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2Jd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:33:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556735C962
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:33:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c7so2730030wrp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=OEZrBCxaknFTMFU0NAWFE13w/K2RkxzEBhZ3jp9e+Ls=;
        b=pIODGRliqHXZnrdnQCZpc577YsSQf1pmtPwDBw2p1RblWUvM89Z+wHH8JKumg6AmQF
         LDXiE5oW1keWpwNtNpxX+Pzeyti49A3pLMqsn0sjh36QShhkaCeuJETtf05GYkft0Ibt
         l1ZFIwjuefh+Kgm24w3i1rRSLtzW9mcUOTYZJkPK8L0fJqRvwIRUSI4ia42GBGQON5pp
         PgbygzZOLbJFVCjoqQ8rBG5LxLyX1XcHbm+QPYC4Gyg+ahhw0rRRgnyeeig4EIPais6C
         eWbQuS7hwARfTuxJ20JVLrlZJmyUSxBRPRGCeGCBqckC39j7ZfH8TnVBvgD6PKSS71Io
         y9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OEZrBCxaknFTMFU0NAWFE13w/K2RkxzEBhZ3jp9e+Ls=;
        b=h6VAUak6jZLEQaAyap+AHc21I9u8VrZ8KssG6pmLGXsZLIWNOWRfAPYeNtklmOB5/M
         sHgWXl+4OAMuID0N+NygI/iY+eUGqXTgHA0MRMoyJm5M56UMLZGMi6z+2/JCyv3A2/mx
         cghE4Ep/VybYQw3i9ZboAqI+OWNtc3oxv7UjiFvBANdZ9YsBoA34w1zcPwMr2CChd37a
         +KDeG6PVyFMc6xgK/uzEVMaNWO0IKYNMbXnfnDqy2zMegEKRdIvT8eHVeAXuCQRtu3vD
         GFniFVcQPXH3mKTdoKBRI7cBuXWE9l0/OoFdA9KdlFDwCWaTMb76sfgU6j6sivhd37q4
         zVbQ==
X-Gm-Message-State: ACgBeo3pd7kkzQoRtR5qHA8zVeRrbwE5CVxuOikcauSW1xDKWwbYktrb
        QHpU0YcNuD/NB3t2GinC4/RbLQ==
X-Google-Smtp-Source: AA6agR6QclHHYEVnw1P0Cr+37FE6FRGUPU98yhw/yhAKKU3clEvU36m+ceZUyLz0SsDl4UgIVE4pDQ==
X-Received: by 2002:a5d:47cd:0:b0:220:70a2:5383 with SMTP id o13-20020a5d47cd000000b0022070a25383mr5900505wrc.258.1661765632312;
        Mon, 29 Aug 2022 02:33:52 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id l5-20020a1c2505000000b003a5ffec0b91sm8342437wml.30.2022.08.29.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:33:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:33:50 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kbuild-all@lists.01.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] clk: mediatek: Provide mtk_devm_alloc_clk_data
Message-ID: <20220829093350.hu734rofg7luwvkp@blmsp>
References: <20220822152652.3499972-3-msp@baylibre.com>
 <202208230714.8DNW6JjZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202208230714.8DNW6JjZ-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 07:44:26AM +0800, kernel test robot wrote:
> Hi Markus,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on robh/for-next linus/master v6.0-rc2 next-20220822]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: loongarch-randconfig-c004-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230714.8DNW6JjZ-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/clk/mediatek/clk-mtk.c:64:1-6: WARNING: invalid free of devm_ allocated data
> 
> vim +64 drivers/clk/mediatek/clk-mtk.c
> 
> 9741b1a68035b54 James Liao    2015-04-23  61  
> 609cc5e1a82394e Chen-Yu Tsai  2022-05-19  62  void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
> 300796cad22153f Chun-Jie Chen 2021-09-14  63  {
> 300796cad22153f Chun-Jie Chen 2021-09-14 @64  	kfree(clk_data);
> 300796cad22153f Chun-Jie Chen 2021-09-14  65  }
> 609cc5e1a82394e Chen-Yu Tsai  2022-05-19  66  EXPORT_SYMBOL_GPL(mtk_free_clk_data);

I don't see how this should be called with clk_data being initialized by
devm_*. Maybe I am bit code blind.

Do you have an actual call stack how this is supposed to happen? Also I
wasn't able to get the same warning with coccinelle (different
compiler).

Best,
Markus
