Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2E5AF475
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIFTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIFT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:29:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85137F9F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:29:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q63so11492842pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/oPGljTY8cn1DwlMVFwHGkojoJ6whUVQ87d7cci0cnM=;
        b=rKp1yJaKC/8ggpz0NVKHlcoF9S5cCAPrrAfxhQlZjUXVmx+6AroPw3sNgq+2yeOFAZ
         wse+WA1WO6kNhXgfQMU4atfiwE0UD6OoOH3CkQeUBHbpKk3hocOiw2/u0r+mXXxwTbC+
         ldNOiAR9o/yXLRaP7juT3+fv49rMhCqn2ABCfK/0fuO9ta3tsRvE13/GJfkOwCIvEBMP
         TETTzJYPNF0tmCtdS//O3MfOp3A84GQYS5hMCDKkxH6m6hkrprDZNVunHhe6IAa/MwiW
         hBts+UIhi4A7R9KjG2i+9BSsstOSDA9pFQ1L/gbAu/euoRD46SN87lLR7ibQQ2Ozb2uy
         d2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/oPGljTY8cn1DwlMVFwHGkojoJ6whUVQ87d7cci0cnM=;
        b=MI47iPWV8xI5pRMR0Au0+vbFfubc0yWo9Hsf7HjM6khkADOQYWYIEwo8dWd4l8/myu
         uqNPdgTcVfEXXzrt+MGWa5movDUIsonWOlQHvNUcLSrFIz6+i+O3F+stXBuKrCB/7IXI
         iWjM7Smg/RVcWwv0x3fQcmqHUsRUzD/7SDdVGPirQV922p04jwH8rYjfl0w6uj3+5X6k
         YNwpOJ5qNpmvV/mQ8idsRliAH9IcWOjDwt9o1Z20EaoMKa6leeV7lxOkqXgEjKhau7Mo
         kb3pAK48fObmyXLbfexs78t4WHSZzDMN2rz937XrNan7ZkQDxHQqcaIHf1VZUyBN3ukj
         q5Kg==
X-Gm-Message-State: ACgBeo3SYWJma5nxyUwBaA4spqQzaWlD8t5lphLT/3RqpdW/L0NdjbY0
        KDz61hGuONpCXJQ6O64zWIxDcA==
X-Google-Smtp-Source: AA6agR5Pb1JdyBBMCPT+TOTyP/Rw3IFwcadkFQ6R2oRFG4/SydRWCfvuMqQVV61fvD6sgTU4xqTrPQ==
X-Received: by 2002:a63:f116:0:b0:434:8607:a54 with SMTP id f22-20020a63f116000000b0043486070a54mr125033pgi.597.1662492592729;
        Tue, 06 Sep 2022 12:29:52 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n16-20020a63a510000000b0042fe1914e26sm2230568pgf.37.2022.09.06.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:29:51 -0700 (PDT)
Date:   Tue, 6 Sep 2022 13:29:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com,
        robh@kernel.org
Subject: Re: [PATCH v5 6/6] remoteproc: pru: add support for configuring
 GPMUX based on client setup
Message-ID: <20220906192949.GA64477@p14s>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-7-p-mohan@ti.com>
 <20220719161625.GB3393732@p14s>
 <49d1959e-88ae-c605-aafc-ca9819c4f85c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49d1959e-88ae-c605-aafc-ca9819c4f85c@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Mon, Sep 05, 2022 at 02:41:27PM +0530, Md Danish Anwar wrote:
> Hi Mathieu,
> 
> On 19/07/22 21:46, Mathieu Poirier wrote:
> > On Tue, Jun 07, 2022 at 10:26:50AM +0530, Puranjay Mohan wrote:
> >> From: Tero Kristo <t-kristo@ti.com>
> >>
> >> Client device node property ti,pruss-gp-mux-sel can now be used to
> >> configure the GPMUX config value for PRU.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> [s-anna@ti.com: simplify the pru id usage]
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> >> ---
> >> V4->v5
> >> * This patch was included in v4 and had some checkpatch errors that have
> >>   been resolved in v5
> >> ---
> >>  drivers/remoteproc/pru_rproc.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> >> index 2977eb50631b..f2c6c55f0f20 100644
> >> --- a/drivers/remoteproc/pru_rproc.c
> >> +++ b/drivers/remoteproc/pru_rproc.c
> >> @@ -123,6 +123,7 @@ struct pru_private_data {
> >>   * @dbg_single_step: debug state variable to set PRU into single step mode
> >>   * @dbg_continuous: debug state variable to restore PRU execution mode
> >>   * @evt_count: number of mapped events
> >> + * @gpmux_save: saved value for gpmux config
> >>   */
> >>  struct pru_rproc {
> >>  	int id;
> >> @@ -141,6 +142,7 @@ struct pru_rproc {
> >>  	u32 dbg_single_step;
> >>  	u32 dbg_continuous;
> >>  	u8 evt_count;
> >> +	u8 gpmux_save;
> >>  };
> >>  
> >>  static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
> >> @@ -250,6 +252,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>  	struct device *dev;
> >>  	const char *fw_name;
> >>  	int ret;
> >> +	u32 mux;
> >>  
> >>  	try_module_get(THIS_MODULE);
> >>  
> >> @@ -273,6 +276,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
> >>  
> >>  	mutex_unlock(&pru->lock);
> >>  
> >> +	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
> >> +	if (ret) {
> >> +		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
> >> +		goto err;
> >> +	}
> >> +
> >> +	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
> >> +					 &mux);
> >> +	if (!ret) {
> >> +		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
> >> +		if (ret) {
> >> +			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
> >> +			goto err;
> >> +		}
> >> +	}
> >> +
> >>  	if (pru_id)
> >>  		*pru_id = pru->id;
> >>  
> >> @@ -310,6 +329,7 @@ void pru_rproc_put(struct rproc *rproc)
> >>  
> >>  	pru = rproc->priv;
> >>  
> >> +	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
> >>  	pru_rproc_set_firmware(rproc, NULL);
> >>
> > 
> >   CC      drivers/remoteproc/pru_rproc.o
> > /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c: In function ‘pru_rproc_get’:
> > /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:279:8: error: implicit declaration of function ‘pruss_cfg_get_gpmux’ [-Werror=implicit-function-declaration]
> >   279 |  ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
> >       |        ^~~~~~~~~~~~~~~~~~~
> > /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:288:9: error: implicit declaration of function ‘pruss_cfg_set_gpmux’ [-Werror=implicit-function-declaration]
> >   288 |   ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
> >       |         ^~~~~~~~~~~~~~~~~~~
> > 
> > I get this on both rproc-next and today's linux next.  
> 
> This patch is dependent on the series [2] Introduce PRU platform consumer API
> https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
> as the api pruss_cfg_get_gpmux calls the api pruss_cfg_read and the api
> pruss_cfg_set_gpmux calls the api pruss_cfg_update which are implemented by the
> patch "soc: ti: pruss: Add pruss_cfg_read()/update() API" in the above series.
>

What I read from the cover letter is that the series you are referring to was an
RFC that predated this series.  Also from the cover letter, the second paragraph
clearly indicate that two other series _depend_ on this series.  As such there
was no way for me to identify the dependency.  

> This error is coming as the dependent patch needs the patch "soc: ti: pruss:
> Add pruss_cfg_read()/update() API" to be applied for compilation.

Please provide a link when referencing patchsets.  That way we know exactly
which one we are talking about.

> 
> Thanks,
> Danish.
> 
> > 
> >>  	mutex_lock(&pru->lock);
> >> -- 
> >> 2.17.1
> >>
