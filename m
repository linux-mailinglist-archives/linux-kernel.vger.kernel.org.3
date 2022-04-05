Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CA4F2165
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiDECxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDECvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:51:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E32DE859
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649123866; x=1680659866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOADr1ud3k4/nTNBXrw6Raun3jnoK5uDvcCwnJ1QY6k=;
  b=iHFtTimFrfnPanCq+x+v/lNlso84GQ66tan9Mqe26z4+ypQGTl4hLxcf
   OPPE2e5RofnAlJo+VD5zoTGlEjpu4ZlmcQBWca5tU42HjxAQaU5hE82lr
   Tk4vsx94pPNZzsP658Y1ehnVPbiMfl3C/NHEye53uj3sPZ9ulEvocSU9j
   MpY5vWrJF1rsefmTXVPrXNKM/QeKPTcRSD/YCe+GMDqnyY2WEd1jkosaX
   VEznnamaQBl59W6lQyK1skHPL6pMyIdtVypgAJVs7c9bfMo5iJMlnnSyI
   6kii6k8na+0+avY7uivMgravWU8n07iWh3rXc2o3xZReQK5rZjr6sw/SR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260623155"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260623155"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:08:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="587749317"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:08:06 -0700
Date:   Mon, 4 Apr 2022 17:10:19 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: r8188eu: add space around arithmatic sign
Message-ID: <20220405001019.GA1200980@alison-desk>
References: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 07:39:16AM -0700, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> CHECK: spaces preferred around that '+' , '-' and '*'
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>

Hi Alaa,

I see you already picked up an ACK on this!

I'm going to comment on the format since I'm aware this is your
first patchset! The grouping is good - 2 cleanups in same file.
Please search in the tutorial for further info on how to present these
as a patchset. You can also peruse the outreachy list for formats of
patchsets as well. I'd expect to see a cover letter.

The other thing I noticed was this: 
>> [PATCH 1/2] staging: r8188eu: add space around arithmatic sign
>> [PATCH 2/2] staging: r8188eu: Add line after declarations
to which I was going to say - 'Well which is the actual preference
for this file or driver: 'add' or 'Add', ie. uppercase or lowercase?  

Looking at the history, it's mixed. So, I guess I'll just suggest
you don't mix it within a patchset.  If a maintainer cares, and try
to set a pattern for the file or driver..

spelling fixup please:
s/arithmatic/arithmetic

and perhpas this would be clearer:
s/sign/operator   (They are arithmetic operators, not signs.)

Alison

> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 58 +++++++++++------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index d68611ef22f8..7c664f80fa99 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -87,19 +87,19 @@ static int skb_pull_and_merge(struct sk_buff *skb, unsigned char *src, int len)
>  	int tail_len;
>  	unsigned long end, tail;
>  
> -	if ((src+len) > skb_tail_pointer(skb) || skb->len < len)
> +	if ((src + len) > skb_tail_pointer(skb) || skb->len < len)
>  		return -1;
>  
>  	tail = (unsigned long)skb_tail_pointer(skb);
> -	end = (unsigned long)src+len;
> +	end = (unsigned long)src + len;
>  	if (tail < end)
>  		return -1;
>  
> -	tail_len = (int)(tail-end);
> +	tail_len = (int)(tail - end);
>  	if (tail_len > 0)
> -		memmove(src, src+len, tail_len);
> +		memmove(src, src + len, tail_len);
>  
> -	skb_trim(skb, skb->len-len);
> +	skb_trim(skb, skb->len - len);
>  	return 0;
>  }
>  
> @@ -117,7 +117,7 @@ static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_IPV4;
> -	memcpy(networkAddr+7, (unsigned char *)ipAddr, 4);
> +	memcpy(networkAddr + 7, (unsigned char *)ipAddr, 4);
>  }
>  
>  static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
> @@ -126,8 +126,8 @@ static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_PPPOE;
> -	memcpy(networkAddr+1, (unsigned char *)sid, 2);
> -	memcpy(networkAddr+3, (unsigned char *)ac_mac, 6);
> +	memcpy(networkAddr + 1, (unsigned char *)sid, 2);
> +	memcpy(networkAddr + 3, (unsigned char *)ac_mac, 6);
>  }
>  
>  static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
> @@ -136,17 +136,17 @@ static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_IPV6;
> -	memcpy(networkAddr+1, (unsigned char *)ipAddr, 16);
> +	memcpy(networkAddr + 1, (unsigned char *)ipAddr, 16);
>  }
>  
>  static unsigned char *scan_tlv(unsigned char *data, int len, unsigned char tag, unsigned char len8b)
>  {
>  	while (len > 0) {
> -		if (*data == tag && *(data+1) == len8b && len >= len8b*8)
> -			return data+2;
> +		if (*data == tag && *(data + 1) == len8b && len >= len8b * 8)
> +			return data + 2;
>  
> -		len -= (*(data+1))*8;
> -		data += (*(data+1))*8;
> +		len -= (*(data + 1)) * 8;
> +		data += (*(data + 1)) * 8;
>  	}
>  	return NULL;
>  }
> @@ -158,7 +158,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  
>  	if (icmphdr->icmp6_type == NDISC_ROUTER_SOLICITATION) {
>  		if (len >= 8) {
> -			mac = scan_tlv(&data[8], len-8, 1, 1);
> +			mac = scan_tlv(&data[8], len - 8, 1, 1);
>  			if (mac) {
>  				memcpy(mac, replace_mac, 6);
>  				return 1;
> @@ -166,7 +166,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  		}
>  	} else if (icmphdr->icmp6_type == NDISC_ROUTER_ADVERTISEMENT) {
>  		if (len >= 16) {
> -			mac = scan_tlv(&data[16], len-16, 1, 1);
> +			mac = scan_tlv(&data[16], len - 16, 1, 1);
>  			if (mac) {
>  				memcpy(mac, replace_mac, 6);
>  				return 1;
> @@ -174,7 +174,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  		}
>  	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) {
>  		if (len >= 24) {
> -			mac = scan_tlv(&data[24], len-24, 1, 1);
> +			mac = scan_tlv(&data[24], len - 24, 1, 1);
>  			if (mac) {
>  				memcpy(mac, replace_mac, 6);
>  				return 1;
> @@ -182,7 +182,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  		}
>  	} else if (icmphdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
>  		if (len >= 24) {
> -			mac = scan_tlv(&data[24], len-24, 2, 1);
> +			mac = scan_tlv(&data[24], len - 24, 2, 1);
>  			if (mac) {
>  				memcpy(mac, replace_mac, 6);
>  				return 1;
> @@ -190,7 +190,7 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  		}
>  	} else if (icmphdr->icmp6_type == NDISC_REDIRECT) {
>  		if (len >= 40) {
> -			mac = scan_tlv(&data[40], len-40, 2, 1);
> +			mac = scan_tlv(&data[40], len - 40, 2, 1);
>  			if (mac) {
>  				memcpy(mac, replace_mac, 6);
>  				return 1;
> @@ -396,7 +396,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			tmp = be32_to_cpu(iph->saddr);
>  			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
>  			/* record source IP address and , source mac address into db */
> -			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
> +			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
>  			return 0;
>  		default:
>  			return -1;
> @@ -421,7 +421,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			arp_ptr += arp->ar_hln;
>  			sender = (unsigned int *)arp_ptr;
>  			__nat25_generate_ipv4_network_addr(networkAddr, sender);
> -			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
> +			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
>  			return 0;
>  		default:
>  			return -1;
> @@ -458,22 +458,22 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  							    sizeof(tag_buf))
>  								return -1;
>  
> -							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
> +							memcpy(tag->tag_data + MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN,
>  								pOldTag->tag_data, old_tag_len);
>  
> -							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0)
> +							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN + old_tag_len) < 0)
>  								return -1;
>  
> -							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
> +							ph->length = htons(ntohs(ph->length) - TAG_HDR_LEN - old_tag_len);
>  						}
>  
>  						tag->tag_type = PTT_RELAY_SID;
> -						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
> +						tag->tag_len = htons(MAGIC_CODE_LEN + RTL_RELAY_TAG_LEN + old_tag_len);
>  
>  						/*  insert the magic_code+client mac in relay tag */
>  						pMagic = (unsigned short *)tag->tag_data;
>  						*pMagic = htons(MAGIC_CODE);
> -						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
> +						memcpy(tag->tag_data + MAGIC_CODE_LEN, skb->data + ETH_ALEN, ETH_ALEN);
>  
>  						/* Add relay tag */
>  						if (__nat25_add_pppoe_tag(skb, tag) < 0)
> @@ -486,7 +486,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  							return -2;
>  
>  						if (priv->pppoe_connection_in_progress == 0)
> -							memcpy(priv->pppoe_addr, skb->data+ETH_ALEN, ETH_ALEN);
> +							memcpy(priv->pppoe_addr, skb->data + ETH_ALEN, ETH_ALEN);
>  
>  						priv->pppoe_connection_in_progress = WAIT_TIME_PPPOE;
>  					}
> @@ -496,11 +496,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			} else {	/*  session phase */
>  				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
>  
> -				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
> +				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
>  
>  				if (!priv->ethBrExtInfo.addPPPoETag &&
>  				    priv->pppoe_connection_in_progress &&
> -				    !memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
> +				    !memcmp(skb->data + ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
>  					priv->pppoe_connection_in_progress = 0;
>  			}
>  			return 0;
> @@ -548,7 +548,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  		case NAT25_INSERT:
>  			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
>  				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
> -				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
> +				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
>  
>  				if (iph->nexthdr == IPPROTO_ICMPV6 &&
>  						skb->len > (ETH_HLEN +  sizeof(*iph) + 4)) {
> -- 
> 2.35.1
> 
> 
