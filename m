Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D934F9D66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiDHTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiDHTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:00:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E0298D52
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649444288; x=1680980288;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+rEtuQz3A7akesKFGWXdBED2FGnRh7XUtnvJdbAu2Lg=;
  b=R3+CbADDAAw29vrFcflnASFx3fOP7k8mUc3Hzn3uYyOhlKTAhdZhHTgt
   xEoCbEFpY1kVM2DsXcPhENhpR9Z6nT5NgMPTgyBvfs710OJxocqmX8nbH
   aEZdFbQoH7hLKLdch2mz0lYtx9/LLS7+5zj2+ShbdW19WBrw9h1RofAYk
   +Fl5M9qPhpUiP0qrc/HAQ7fps7m//9IgQmY+HkNcrsbctQ6Xe/uewccAj
   aGqQndrmcjHJ8xp9BkNRw1hH2UrTV9fTOp9KI/VsoCE+kkyYxKk3di96E
   xyONbe3pkXF8PQ+F1NKlLCMLzYU22SyNOaJRhRJu5FpoMuqyT/XQycP0n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261657419"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261657419"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="653373248"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 11:58:03 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncto2-0000YN-E7;
        Fri, 08 Apr 2022 18:58:02 +0000
Date:   Sat, 9 Apr 2022 02:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kari Suvanto <karis79@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Malik Olivier Boussejra <malik@boussejra.com>,
        Paul Zimmerman <paulz@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Michael Zoran <mzoran@crowfest.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Jonathan Bell <jonathan@raspberrypi.org>,
        Hui Wang <hui.wang@canonical.com>,
        Zixuan Wang <wangzixuan@sjtu.edu.cn>
Subject: [l1k:smsc95xx_5.17 56/887] drivers/usb/core/message.c:2155:36:
 sparse: sparse: restricted __le16 degrades to integer
Message-ID: <202204090227.0vFmXBXd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: a8197852bb8f1f6804cff9442d426888e97aaed3 [56/887] Add dwc_otg driver
config: nios2-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090227.0vFmXBXd-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/l1k/linux/commit/a8197852bb8f1f6804cff9442d426888e97aaed3
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout a8197852bb8f1f6804cff9442d426888e97aaed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/core/message.c:2155:36: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/core/message.c:2163:56: sparse: sparse: restricted __le16 degrades to integer

vim +2155 drivers/usb/core/message.c

  1909	
  1910	
  1911	/*
  1912	 * usb_set_configuration - Makes a particular device setting be current
  1913	 * @dev: the device whose configuration is being updated
  1914	 * @configuration: the configuration being chosen.
  1915	 *
  1916	 * Context: task context, might sleep. Caller holds device lock.
  1917	 *
  1918	 * This is used to enable non-default device modes.  Not all devices
  1919	 * use this kind of configurability; many devices only have one
  1920	 * configuration.
  1921	 *
  1922	 * @configuration is the value of the configuration to be installed.
  1923	 * According to the USB spec (e.g. section 9.1.1.5), configuration values
  1924	 * must be non-zero; a value of zero indicates that the device in
  1925	 * unconfigured.  However some devices erroneously use 0 as one of their
  1926	 * configuration values.  To help manage such devices, this routine will
  1927	 * accept @configuration = -1 as indicating the device should be put in
  1928	 * an unconfigured state.
  1929	 *
  1930	 * USB device configurations may affect Linux interoperability,
  1931	 * power consumption and the functionality available.  For example,
  1932	 * the default configuration is limited to using 100mA of bus power,
  1933	 * so that when certain device functionality requires more power,
  1934	 * and the device is bus powered, that functionality should be in some
  1935	 * non-default device configuration.  Other device modes may also be
  1936	 * reflected as configuration options, such as whether two ISDN
  1937	 * channels are available independently; and choosing between open
  1938	 * standard device protocols (like CDC) or proprietary ones.
  1939	 *
  1940	 * Note that a non-authorized device (dev->authorized == 0) will only
  1941	 * be put in unconfigured mode.
  1942	 *
  1943	 * Note that USB has an additional level of device configurability,
  1944	 * associated with interfaces.  That configurability is accessed using
  1945	 * usb_set_interface().
  1946	 *
  1947	 * This call is synchronous. The calling context must be able to sleep,
  1948	 * must own the device lock, and must not hold the driver model's USB
  1949	 * bus mutex; usb interface driver probe() methods cannot use this routine.
  1950	 *
  1951	 * Returns zero on success, or else the status code returned by the
  1952	 * underlying call that failed.  On successful completion, each interface
  1953	 * in the original device configuration has been destroyed, and each one
  1954	 * in the new configuration has been probed by all relevant usb device
  1955	 * drivers currently known to the kernel.
  1956	 */
  1957	int usb_set_configuration(struct usb_device *dev, int configuration)
  1958	{
  1959		int i, ret;
  1960		struct usb_host_config *cp = NULL;
  1961		struct usb_interface **new_interfaces = NULL;
  1962		struct usb_hcd *hcd = bus_to_hcd(dev->bus);
  1963		int n, nintf;
  1964	
  1965		if (dev->authorized == 0 || configuration == -1)
  1966			configuration = 0;
  1967		else {
  1968			for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
  1969				if (dev->config[i].desc.bConfigurationValue ==
  1970						configuration) {
  1971					cp = &dev->config[i];
  1972					break;
  1973				}
  1974			}
  1975		}
  1976		if ((!cp && configuration != 0))
  1977			return -EINVAL;
  1978	
  1979		/* The USB spec says configuration 0 means unconfigured.
  1980		 * But if a device includes a configuration numbered 0,
  1981		 * we will accept it as a correctly configured state.
  1982		 * Use -1 if you really want to unconfigure the device.
  1983		 */
  1984		if (cp && configuration == 0)
  1985			dev_warn(&dev->dev, "config 0 descriptor??\n");
  1986	
  1987		/* Allocate memory for new interfaces before doing anything else,
  1988		 * so that if we run out then nothing will have changed. */
  1989		n = nintf = 0;
  1990		if (cp) {
  1991			nintf = cp->desc.bNumInterfaces;
  1992			new_interfaces = kmalloc_array(nintf, sizeof(*new_interfaces),
  1993						       GFP_NOIO);
  1994			if (!new_interfaces)
  1995				return -ENOMEM;
  1996	
  1997			for (; n < nintf; ++n) {
  1998				new_interfaces[n] = kzalloc(
  1999						sizeof(struct usb_interface),
  2000						GFP_NOIO);
  2001				if (!new_interfaces[n]) {
  2002					ret = -ENOMEM;
  2003	free_interfaces:
  2004					while (--n >= 0)
  2005						kfree(new_interfaces[n]);
  2006					kfree(new_interfaces);
  2007					return ret;
  2008				}
  2009			}
  2010	
  2011			i = dev->bus_mA - usb_get_max_power(dev, cp);
  2012			if (i < 0)
  2013				dev_warn(&dev->dev, "new config #%d exceeds power "
  2014						"limit by %dmA\n",
  2015						configuration, -i);
  2016		}
  2017	
  2018		/* Wake up the device so we can send it the Set-Config request */
  2019		ret = usb_autoresume_device(dev);
  2020		if (ret)
  2021			goto free_interfaces;
  2022	
  2023		/* if it's already configured, clear out old state first.
  2024		 * getting rid of old interfaces means unbinding their drivers.
  2025		 */
  2026		if (dev->state != USB_STATE_ADDRESS)
  2027			usb_disable_device(dev, 1);	/* Skip ep0 */
  2028	
  2029		/* Get rid of pending async Set-Config requests for this device */
  2030		cancel_async_set_config(dev);
  2031	
  2032		/* Make sure we have bandwidth (and available HCD resources) for this
  2033		 * configuration.  Remove endpoints from the schedule if we're dropping
  2034		 * this configuration to set configuration 0.  After this point, the
  2035		 * host controller will not allow submissions to dropped endpoints.  If
  2036		 * this call fails, the device state is unchanged.
  2037		 */
  2038		mutex_lock(hcd->bandwidth_mutex);
  2039		/* Disable LPM, and re-enable it once the new configuration is
  2040		 * installed, so that the xHCI driver can recalculate the U1/U2
  2041		 * timeouts.
  2042		 */
  2043		if (dev->actconfig && usb_disable_lpm(dev)) {
  2044			dev_err(&dev->dev, "%s Failed to disable LPM\n", __func__);
  2045			mutex_unlock(hcd->bandwidth_mutex);
  2046			ret = -ENOMEM;
  2047			goto free_interfaces;
  2048		}
  2049		ret = usb_hcd_alloc_bandwidth(dev, cp, NULL, NULL);
  2050		if (ret < 0) {
  2051			if (dev->actconfig)
  2052				usb_enable_lpm(dev);
  2053			mutex_unlock(hcd->bandwidth_mutex);
  2054			usb_autosuspend_device(dev);
  2055			goto free_interfaces;
  2056		}
  2057	
  2058		/*
  2059		 * Initialize the new interface structures and the
  2060		 * hc/hcd/usbcore interface/endpoint state.
  2061		 */
  2062		for (i = 0; i < nintf; ++i) {
  2063			struct usb_interface_cache *intfc;
  2064			struct usb_interface *intf;
  2065			struct usb_host_interface *alt;
  2066			u8 ifnum;
  2067	
  2068			cp->interface[i] = intf = new_interfaces[i];
  2069			intfc = cp->intf_cache[i];
  2070			intf->altsetting = intfc->altsetting;
  2071			intf->num_altsetting = intfc->num_altsetting;
  2072			intf->authorized = !!HCD_INTF_AUTHORIZED(hcd);
  2073			kref_get(&intfc->ref);
  2074	
  2075			alt = usb_altnum_to_altsetting(intf, 0);
  2076	
  2077			/* No altsetting 0?  We'll assume the first altsetting.
  2078			 * We could use a GetInterface call, but if a device is
  2079			 * so non-compliant that it doesn't have altsetting 0
  2080			 * then I wouldn't trust its reply anyway.
  2081			 */
  2082			if (!alt)
  2083				alt = &intf->altsetting[0];
  2084	
  2085			ifnum = alt->desc.bInterfaceNumber;
  2086			intf->intf_assoc = find_iad(dev, cp, ifnum);
  2087			intf->cur_altsetting = alt;
  2088			usb_enable_interface(dev, intf, true);
  2089			intf->dev.parent = &dev->dev;
  2090			if (usb_of_has_combined_node(dev)) {
  2091				device_set_of_node_from_dev(&intf->dev, &dev->dev);
  2092			} else {
  2093				intf->dev.of_node = usb_of_get_interface_node(dev,
  2094						configuration, ifnum);
  2095			}
  2096			ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
  2097			intf->dev.driver = NULL;
  2098			intf->dev.bus = &usb_bus_type;
  2099			intf->dev.type = &usb_if_device_type;
  2100			intf->dev.groups = usb_interface_groups;
  2101			INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
  2102			intf->minor = -1;
  2103			device_initialize(&intf->dev);
  2104			pm_runtime_no_callbacks(&intf->dev);
  2105			dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
  2106					dev->devpath, configuration, ifnum);
  2107			usb_get_dev(dev);
  2108		}
  2109		kfree(new_interfaces);
  2110	
  2111		ret = usb_control_msg_send(dev, 0, USB_REQ_SET_CONFIGURATION, 0,
  2112					   configuration, 0, NULL, 0,
  2113					   USB_CTRL_SET_TIMEOUT, GFP_NOIO);
  2114		if (ret && cp) {
  2115			/*
  2116			 * All the old state is gone, so what else can we do?
  2117			 * The device is probably useless now anyway.
  2118			 */
  2119			usb_hcd_alloc_bandwidth(dev, NULL, NULL, NULL);
  2120			for (i = 0; i < nintf; ++i) {
  2121				usb_disable_interface(dev, cp->interface[i], true);
  2122				put_device(&cp->interface[i]->dev);
  2123				cp->interface[i] = NULL;
  2124			}
  2125			cp = NULL;
  2126		}
  2127	
  2128		dev->actconfig = cp;
  2129		mutex_unlock(hcd->bandwidth_mutex);
  2130	
  2131		if (!cp) {
  2132			usb_set_device_state(dev, USB_STATE_ADDRESS);
  2133	
  2134			/* Leave LPM disabled while the device is unconfigured. */
  2135			usb_autosuspend_device(dev);
  2136			return ret;
  2137		}
  2138		usb_set_device_state(dev, USB_STATE_CONFIGURED);
  2139	
  2140		if (cp->string == NULL &&
  2141				!(dev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
  2142			cp->string = usb_cache_string(dev, cp->desc.iConfiguration);
  2143	/* Uncomment this define to enable the HS Electrical Test support */
  2144	#define DWC_HS_ELECT_TST 1
  2145	#ifdef DWC_HS_ELECT_TST
  2146			/* Here we implement the HS Electrical Test support. The
  2147			 * tester uses a vendor ID of 0x1A0A to indicate we should
  2148			 * run a special test sequence. The product ID tells us
  2149			 * which sequence to run. We invoke the test sequence by
  2150			 * sending a non-standard SetFeature command to our root
  2151			 * hub port. Our dwc_otg_hcd_hub_control() routine will
  2152			 * recognize the command and perform the desired test
  2153			 * sequence.
  2154			 */
> 2155			if (dev->descriptor.idVendor == 0x1A0A) {
  2156				/* HSOTG Electrical Test */
  2157				dev_warn(&dev->dev, "VID from HSOTG Electrical Test Fixture\n");
  2158	
  2159				if (dev->bus && dev->bus->root_hub) {
  2160					struct usb_device *hdev = dev->bus->root_hub;
  2161					dev_warn(&dev->dev, "Got PID 0x%x\n", dev->descriptor.idProduct);
  2162	
  2163					switch (dev->descriptor.idProduct) {
  2164					case 0x0101:	/* TEST_SE0_NAK */
  2165						dev_warn(&dev->dev, "TEST_SE0_NAK\n");
  2166						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2167								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2168								USB_PORT_FEAT_TEST, 0x300, NULL, 0, HZ);
  2169						break;
  2170	
  2171					case 0x0102:	/* TEST_J */
  2172						dev_warn(&dev->dev, "TEST_J\n");
  2173						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2174								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2175								USB_PORT_FEAT_TEST, 0x100, NULL, 0, HZ);
  2176						break;
  2177	
  2178					case 0x0103:	/* TEST_K */
  2179						dev_warn(&dev->dev, "TEST_K\n");
  2180						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2181								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2182								USB_PORT_FEAT_TEST, 0x200, NULL, 0, HZ);
  2183						break;
  2184	
  2185					case 0x0104:	/* TEST_PACKET */
  2186						dev_warn(&dev->dev, "TEST_PACKET\n");
  2187						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2188								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2189								USB_PORT_FEAT_TEST, 0x400, NULL, 0, HZ);
  2190						break;
  2191	
  2192					case 0x0105:	/* TEST_FORCE_ENABLE */
  2193						dev_warn(&dev->dev, "TEST_FORCE_ENABLE\n");
  2194						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2195								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2196								USB_PORT_FEAT_TEST, 0x500, NULL, 0, HZ);
  2197						break;
  2198	
  2199					case 0x0106:	/* HS_HOST_PORT_SUSPEND_RESUME */
  2200						dev_warn(&dev->dev, "HS_HOST_PORT_SUSPEND_RESUME\n");
  2201						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2202								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2203								USB_PORT_FEAT_TEST, 0x600, NULL, 0, 40 * HZ);
  2204						break;
  2205	
  2206					case 0x0107:	/* SINGLE_STEP_GET_DEVICE_DESCRIPTOR setup */
  2207						dev_warn(&dev->dev, "SINGLE_STEP_GET_DEVICE_DESCRIPTOR setup\n");
  2208						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2209								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2210								USB_PORT_FEAT_TEST, 0x700, NULL, 0, 40 * HZ);
  2211						break;
  2212	
  2213					case 0x0108:	/* SINGLE_STEP_GET_DEVICE_DESCRIPTOR execute */
  2214						dev_warn(&dev->dev, "SINGLE_STEP_GET_DEVICE_DESCRIPTOR execute\n");
  2215						usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
  2216								USB_REQ_SET_FEATURE, USB_RT_PORT,
  2217								USB_PORT_FEAT_TEST, 0x800, NULL, 0, 40 * HZ);
  2218					}
  2219				}
  2220			}
  2221	#endif /* DWC_HS_ELECT_TST */
  2222	
  2223		/* Now that the interfaces are installed, re-enable LPM. */
  2224		usb_unlocked_enable_lpm(dev);
  2225		/* Enable LTM if it was turned off by usb_disable_device. */
  2226		usb_enable_ltm(dev);
  2227	
  2228		/* Now that all the interfaces are set up, register them
  2229		 * to trigger binding of drivers to interfaces.  probe()
  2230		 * routines may install different altsettings and may
  2231		 * claim() any interfaces not yet bound.  Many class drivers
  2232		 * need that: CDC, audio, video, etc.
  2233		 */
  2234		for (i = 0; i < nintf; ++i) {
  2235			struct usb_interface *intf = cp->interface[i];
  2236	
  2237			if (intf->dev.of_node &&
  2238			    !of_device_is_available(intf->dev.of_node)) {
  2239				dev_info(&dev->dev, "skipping disabled interface %d\n",
  2240					 intf->cur_altsetting->desc.bInterfaceNumber);
  2241				continue;
  2242			}
  2243	
  2244			dev_dbg(&dev->dev,
  2245				"adding %s (config #%d, interface %d)\n",
  2246				dev_name(&intf->dev), configuration,
  2247				intf->cur_altsetting->desc.bInterfaceNumber);
  2248			device_enable_async_suspend(&intf->dev);
  2249			ret = device_add(&intf->dev);
  2250			if (ret != 0) {
  2251				dev_err(&dev->dev, "device_add(%s) --> %d\n",
  2252					dev_name(&intf->dev), ret);
  2253				continue;
  2254			}
  2255			create_intf_ep_devs(intf);
  2256		}
  2257	
  2258		usb_autosuspend_device(dev);
  2259		return 0;
  2260	}
  2261	EXPORT_SYMBOL_GPL(usb_set_configuration);
  2262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
