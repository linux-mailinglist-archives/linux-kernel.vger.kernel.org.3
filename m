Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16BF54D605
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiFPARz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbiFPARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:17:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399D255AA;
        Wed, 15 Jun 2022 17:17:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q15so7116255wmj.2;
        Wed, 15 Jun 2022 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aDFzDq54JiCUJ9bH5+ojvGT3soC1A7JouZz/quQ+US0=;
        b=IlogWXO1gcyue/Wz5QekpFNXjYHeEtu2RxP3cUoLgrnhX5BzWrnqfKLnJfu5N+rEKN
         v9aB63DJRSRb0/hI1IUOo8cvqDAJMdG+HYei9Q2Iy4aE3WG9vjdp73DGrA1V1LvN+wUe
         FreLyghOoRUSFSCsqPhA5vyFe7oLfSmehM+U65LwHJcN/roeO/HbX4yDId9vC6HyXuOl
         UAmMyaY+Rh9tZ138OfBuog4BDrcqkbCR7vzUq4BxqX7QDHKfPOgwFt7h4cSOFrkIfwIU
         Nv5wbiy4ND3QUY7bxLV3nmiN8oQryrTPziQTlKtGZuGoio+rceYZ2mKdcpIzgCLVgwsE
         d4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aDFzDq54JiCUJ9bH5+ojvGT3soC1A7JouZz/quQ+US0=;
        b=kuDKI+BaPd3Wa9RBi31g19PuHS8G/t1kgB+Tok++5880epDg45tRmCrmaFxUqQjfbJ
         tC01vx7GnXm5m5+asQR4jCqyg7blfRl8H1TbvP+2LwwIS9np9pYx7aykHbojQ2eGc93i
         PaKCEp+cxZ0WhcYP3aRpZIH2nJ1oqsv65RmDgJRzCNHzOv/m8W7Df9MmrxrUQIUVh8Cr
         MC+Zb61WN5+TivHkLlmUDs72/bacsp2UNGghufi16gg158ts+UOcHq4ajLbcmH6N/4iT
         tH2WUSOi6TCTyi61O7frhV6DVZ3QhttbAjgRqQhROWM8s9hKhOlmV59/Vpfyr+3y67qU
         4TlA==
X-Gm-Message-State: AJIora/4GY2B3ubOpYobV8REAJ9hWHOJUshJS7D6Np8x/Jb9GCFDstvQ
        fjbHttcs+V4pWz0acKw+1cA=
X-Google-Smtp-Source: AGRyM1vZD6jtH1N3IO87Vi0fAgsO8OlxJTZhgBV4cSpO2pfObOs6AIqeTcGZQ3vd6FP3/HVVPIHBOA==
X-Received: by 2002:a05:600c:2143:b0:39c:5539:c64f with SMTP id v3-20020a05600c214300b0039c5539c64fmr2001521wml.194.1655338669512;
        Wed, 15 Jun 2022 17:17:49 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc31a000000b00397623ff335sm449665wmj.10.2022.06.15.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:17:49 -0700 (PDT)
Message-ID: <62aa76ad.1c69fb81.7e2d3.0c8e@mx.google.com>
X-Google-Original-Message-ID: <Yqp2wAyG/XdFxTNo@Ansuel-xps.>
Date:   Thu, 16 Jun 2022 02:18:08 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
 <20220615000612.3119-2-ansuelsmth@gmail.com>
 <20220615171132.GA3606@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615171132.GA3606@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:41:32PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 15, 2022 at 02:06:10AM +0200, Ansuel Smith wrote:
> > Reorder structs in nandc driver to save holes.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks,
> Mani
>

I'm sending v8 with a different Sob so I'm not adding the review tag (in
v8).
In short the new Sob is what I will use onwards, wanted to keep the
Ansuel reference but it was suggested to use Christian Marangi and
nothing more. It's just a name change and we are the same person and
nobody is stealing ownership of the patch.
Sorry for the mess.

> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 107 +++++++++++++++++-------------
> >  1 file changed, 62 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 1a77542c6d67..f2990d721733 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -238,6 +238,9 @@ nandc_set_reg(chip, reg,			\
> >   * @bam_ce - the array of BAM command elements
> >   * @cmd_sgl - sgl for NAND BAM command pipe
> >   * @data_sgl - sgl for NAND BAM consumer/producer pipe
> > + * @last_data_desc - last DMA desc in data channel (tx/rx).
> > + * @last_cmd_desc - last DMA desc in command channel.
> > + * @txn_done - completion for NAND transfer.
> >   * @bam_ce_pos - the index in bam_ce which is available for next sgl
> >   * @bam_ce_start - the index in bam_ce which marks the start position ce
> >   *		   for current sgl. It will be used for size calculation
> > @@ -250,14 +253,14 @@ nandc_set_reg(chip, reg,			\
> >   * @rx_sgl_start - start index in data sgl for rx.
> >   * @wait_second_completion - wait for second DMA desc completion before making
> >   *			     the NAND transfer completion.
> > - * @txn_done - completion for NAND transfer.
> > - * @last_data_desc - last DMA desc in data channel (tx/rx).
> > - * @last_cmd_desc - last DMA desc in command channel.
> >   */
> >  struct bam_transaction {
> >  	struct bam_cmd_element *bam_ce;
> >  	struct scatterlist *cmd_sgl;
> >  	struct scatterlist *data_sgl;
> > +	struct dma_async_tx_descriptor *last_data_desc;
> > +	struct dma_async_tx_descriptor *last_cmd_desc;
> > +	struct completion txn_done;
> >  	u32 bam_ce_pos;
> >  	u32 bam_ce_start;
> >  	u32 cmd_sgl_pos;
> > @@ -267,25 +270,23 @@ struct bam_transaction {
> >  	u32 rx_sgl_pos;
> >  	u32 rx_sgl_start;
> >  	bool wait_second_completion;
> > -	struct completion txn_done;
> > -	struct dma_async_tx_descriptor *last_data_desc;
> > -	struct dma_async_tx_descriptor *last_cmd_desc;
> >  };
> >  
> >  /*
> >   * This data type corresponds to the nand dma descriptor
> > + * @dma_desc - low level DMA engine descriptor
> >   * @list - list for desc_info
> > - * @dir - DMA transfer direction
> > + *
> >   * @adm_sgl - sgl which will be used for single sgl dma descriptor. Only used by
> >   *	      ADM
> >   * @bam_sgl - sgl which will be used for dma descriptor. Only used by BAM
> >   * @sgl_cnt - number of SGL in bam_sgl. Only used by BAM
> > - * @dma_desc - low level DMA engine descriptor
> > + * @dir - DMA transfer direction
> >   */
> >  struct desc_info {
> > +	struct dma_async_tx_descriptor *dma_desc;
> >  	struct list_head node;
> >  
> > -	enum dma_data_direction dir;
> >  	union {
> >  		struct scatterlist adm_sgl;
> >  		struct {
> > @@ -293,7 +294,7 @@ struct desc_info {
> >  			int sgl_cnt;
> >  		};
> >  	};
> > -	struct dma_async_tx_descriptor *dma_desc;
> > +	enum dma_data_direction dir;
> >  };
> >  
> >  /*
> > @@ -337,52 +338,64 @@ struct nandc_regs {
> >  /*
> >   * NAND controller data struct
> >   *
> > - * @controller:			base controller structure
> > - * @host_list:			list containing all the chips attached to the
> > - *				controller
> >   * @dev:			parent device
> > + *
> >   * @base:			MMIO base
> > - * @base_phys:			physical base address of controller registers
> > - * @base_dma:			dma base address of controller registers
> > + *
> >   * @core_clk:			controller clock
> >   * @aon_clk:			another controller clock
> >   *
> > + * @regs:			a contiguous chunk of memory for DMA register
> > + *				writes. contains the register values to be
> > + *				written to controller
> > + *
> > + * @props:			properties of current NAND controller,
> > + *				initialized via DT match data
> > + *
> > + * @controller:			base controller structure
> > + * @host_list:			list containing all the chips attached to the
> > + *				controller
> > + *
> >   * @chan:			dma channel
> >   * @cmd_crci:			ADM DMA CRCI for command flow control
> >   * @data_crci:			ADM DMA CRCI for data flow control
> > + *
> >   * @desc_list:			DMA descriptor list (list of desc_infos)
> >   *
> >   * @data_buffer:		our local DMA buffer for page read/writes,
> >   *				used when we can't use the buffer provided
> >   *				by upper layers directly
> > - * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
> > - *				functions
> >   * @reg_read_buf:		local buffer for reading back registers via DMA
> > + *
> > + * @base_phys:			physical base address of controller registers
> > + * @base_dma:			dma base address of controller registers
> >   * @reg_read_dma:		contains dma address for register read buffer
> > - * @reg_read_pos:		marker for data read in reg_read_buf
> >   *
> > - * @regs:			a contiguous chunk of memory for DMA register
> > - *				writes. contains the register values to be
> > - *				written to controller
> > - * @cmd1/vld:			some fixed controller register values
> > - * @props:			properties of current NAND controller,
> > - *				initialized via DT match data
> > + * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
> > + *				functions
> >   * @max_cwperpage:		maximum QPIC codewords required. calculated
> >   *				from all connected NAND devices pagesize
> > + *
> > + * @reg_read_pos:		marker for data read in reg_read_buf
> > + *
> > + * @cmd1/vld:			some fixed controller register values
> >   */
> >  struct qcom_nand_controller {
> > -	struct nand_controller controller;
> > -	struct list_head host_list;
> > -
> >  	struct device *dev;
> >  
> >  	void __iomem *base;
> > -	phys_addr_t base_phys;
> > -	dma_addr_t base_dma;
> >  
> >  	struct clk *core_clk;
> >  	struct clk *aon_clk;
> >  
> > +	struct nandc_regs *regs;
> > +	struct bam_transaction *bam_txn;
> > +
> > +	const struct qcom_nandc_props *props;
> > +
> > +	struct nand_controller controller;
> > +	struct list_head host_list;
> > +
> >  	union {
> >  		/* will be used only by QPIC for BAM DMA */
> >  		struct {
> > @@ -400,22 +413,22 @@ struct qcom_nand_controller {
> >  	};
> >  
> >  	struct list_head desc_list;
> > -	struct bam_transaction *bam_txn;
> >  
> >  	u8		*data_buffer;
> > +	__le32		*reg_read_buf;
> > +
> > +	phys_addr_t base_phys;
> > +	dma_addr_t base_dma;
> > +	dma_addr_t reg_read_dma;
> > +
> >  	int		buf_size;
> >  	int		buf_count;
> >  	int		buf_start;
> >  	unsigned int	max_cwperpage;
> >  
> > -	__le32 *reg_read_buf;
> > -	dma_addr_t reg_read_dma;
> >  	int reg_read_pos;
> >  
> > -	struct nandc_regs *regs;
> > -
> >  	u32 cmd1, vld;
> > -	const struct qcom_nandc_props *props;
> >  };
> >  
> >  /*
> > @@ -431,19 +444,21 @@ struct qcom_nand_controller {
> >   *				and reserved bytes
> >   * @cw_data:			the number of bytes within a codeword protected
> >   *				by ECC
> > - * @use_ecc:			request the controller to use ECC for the
> > - *				upcoming read/write
> > - * @bch_enabled:		flag to tell whether BCH ECC mode is used
> >   * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> >   *				chip
> > - * @status:			value to be returned if NAND_CMD_STATUS command
> > - *				is executed
> > + *
> >   * @last_command:		keeps track of last command on this chip. used
> >   *				for reading correct status
> >   *
> >   * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
> >   *				ecc/non-ecc mode for the current nand flash
> >   *				device
> > + *
> > + * @status:			value to be returned if NAND_CMD_STATUS command
> > + *				is executed
> > + * @use_ecc:			request the controller to use ECC for the
> > + *				upcoming read/write
> > + * @bch_enabled:		flag to tell whether BCH ECC mode is used
> >   */
> >  struct qcom_nand_host {
> >  	struct nand_chip chip;
> > @@ -452,12 +467,10 @@ struct qcom_nand_host {
> >  	int cs;
> >  	int cw_size;
> >  	int cw_data;
> > -	bool use_ecc;
> > -	bool bch_enabled;
> >  	int ecc_bytes_hw;
> >  	int spare_bytes;
> >  	int bbm_size;
> > -	u8 status;
> > +
> >  	int last_command;
> >  
> >  	u32 cfg0, cfg1;
> > @@ -466,23 +479,27 @@ struct qcom_nand_host {
> >  	u32 ecc_bch_cfg;
> >  	u32 clrflashstatus;
> >  	u32 clrreadstatus;
> > +
> > +	u8 status;
> > +	bool use_ecc;
> > +	bool bch_enabled;
> >  };
> >  
> >  /*
> >   * This data type corresponds to the NAND controller properties which varies
> >   * among different NAND controllers.
> >   * @ecc_modes - ecc mode for NAND
> > + * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
> >   * @is_bam - whether NAND controller is using BAM
> >   * @is_qpic - whether NAND CTRL is part of qpic IP
> >   * @qpic_v2 - flag to indicate QPIC IP version 2
> > - * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
> >   */
> >  struct qcom_nandc_props {
> >  	u32 ecc_modes;
> > +	u32 dev_cmd_reg_start;
> >  	bool is_bam;
> >  	bool is_qpic;
> >  	bool qpic_v2;
> > -	u32 dev_cmd_reg_start;
> >  };
> >  
> >  /* Frees the BAM transaction memory */
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
